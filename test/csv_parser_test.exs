defmodule ClientImporter.CSVParserTest do
  use ExUnit.Case

  alias ClientImporter.CSVParser

  describe "parsing a csv" do
    test "failure: invalid data" do
     result = CSVParser.parse("test/fixtures/client_importer_invalid_data.csv", "email")

     assert result == {:error, :unable_to_parse}
    end

    test "success: empty file" do
     result = CSVParser.parse("test/fixtures/client_importer_empty.csv", "email")

      assert result == :ok
    end

    test "success: valid file for email" do
     result = CSVParser.parse("test/fixtures/client_importer_valid.csv", "email")

      assert result == :ok
      assert "priv/repo/csv/scrubbed_data/clients_by_unique_email.csv"

      scrubbed_file = File.read!("priv/repo/csv/scrubbed_data/clients_by_unique_email.csv")
      refute String.contains?(scrubbed_file, "Alfie")
    end

    test "success: valid file for phone" do
     result = CSVParser.parse("test/fixtures/client_importer_valid.csv", "phone")

      assert result == :ok
      assert "priv/repo/csv/scrubbed_data/clients_by_unique_phone.csv"

      scrubbed_file = File.read!("priv/repo/csv/scrubbed_data/clients_by_unique_phone.csv")
      refute String.contains?(scrubbed_file, "Teresa")
    end

    test "success: valid file for email or phone" do
     result = CSVParser.parse("test/fixtures/client_importer_valid.csv", "email_or_phone")

      assert result == :ok
      assert "priv/repo/csv/scrubbed_data/clients_by_unique_phone_and_email.csv"

      scrubbed_file = File.read!("priv/repo/csv/scrubbed_data/clients_by_unique_phone_and_email.csv")
      refute String.contains?(scrubbed_file, "Alfie")
      refute String.contains?(scrubbed_file, "Teresa")
    end
  end
end
