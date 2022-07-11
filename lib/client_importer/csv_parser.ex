defmodule ClientImporter.CSVParser do
  NimbleCSV.define(ClientImporter.CSV, separator: ",", escape: "\"")

  alias ClientImporter.CSV

  def parse(file, strategy) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> find_dupes(strategy)
  end

  defp find_dupes(data, "email") do
    try do
      unique_items =
        data
        |> Enum.uniq_by(fn [_, _, email, _] ->
          check_is_binary(email)
        end)
        |> CSV.dump_to_iodata()

      File.write!("priv/repo/csv/cleaned_data/clients_by_unique_email.csv", unique_items)
    rescue
      e ->
        IO.inspect(e)
        {:error, :unable_to_parse}
    end
  end

  defp find_dupes(data, "phone") do
    try do
      unique_items =
        data
        |> Enum.uniq_by(fn [_, _, _, phone] -> check_is_binary(phone) end)
        |> CSV.dump_to_iodata()

      File.write!("priv/repo/csv/cleaned_data/clients_by_unique_phone.csv", unique_items)
    rescue
      e ->
        IO.inspect(e)
        {:error, :unable_to_parse}
    end
  end

  defp find_dupes(data, "email_or_phone") do
    try do
      unique_items =
        data
        |> Enum.uniq_by(fn [_, _, email, _] -> check_is_binary(email) end)
        |> Enum.uniq_by(fn [_, _, _, phone] -> check_is_binary(phone) end)
        |> CSV.dump_to_iodata()

      File.write!("priv/repo/csv/cleaned_data/clients_by_unique_phone_and_email.csv", unique_items)
    rescue
      e ->
        IO.inspect(e)
        {:error, :unable_to_parse}
    end
  end

  defp check_is_binary(value) when is_binary(value), do: value

  defp check_is_binary(_value), do: raise "Invalid type"
end
