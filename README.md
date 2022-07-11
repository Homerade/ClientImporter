# ClientImporter

ClientImporter is a test app for client importing. Use the module created to import a CSV file and remove duplicates via one of the provided strategies.
## Prerequisites

This project does not include `.tool-versions`, but make sure you have the required dependencies installed:
  * PostgreSQL
  * Elixir
  * Erlang

I use [asdf](https://asdf-vm.com/) for project versions and currently have these versions installed:
  * Elixir 1.12.3
  * Erlang 23.1.2

## App Setup

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Running the importer

* Start an interactive server with `iex -S mix phx.server`
* Select a file
* Select a de-dupe strategy
* Run the import function

example:
```
iex> ClientImporter.CSVParser.parse("priv/repo/csv/source_data/client_import.csv", "email")
```

This will result in a de-duped file created in `"priv/repo/csv/cleaned_data/.."`

Note: there is an example file for import provided here: `"priv/repo/csv/source_data/client_import.csv"`

_Troubleshooting: you may need to run `recompile` in iex instance in terminal if you find it unable to run the module function_
## Testing

Run the automated test suite from terminal using `mix test`

_make sure to stop the server `ctrl + c` before running tests_
## Where to go from here

More sophisitcated import checks
- Use reduce on rows to clean based on more parameters
- Identify more ways CSV could have corrupted data and add abstracted functions for each

Better CSV creation
- Chunking results
- separate adding headers and content
