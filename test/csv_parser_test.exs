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
    end

    test "success: valid file for phone" do
     result = CSVParser.parse("test/fixtures/client_importer_valid.csv", "phone")

      assert result == :ok
    end

    test "success: valid file for email or phone" do
     result = CSVParser.parse("test/fixtures/client_importer_valid.csv", "email_or_phone")

      assert result == :ok
    end
  end
end
