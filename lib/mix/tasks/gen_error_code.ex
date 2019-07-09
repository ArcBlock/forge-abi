defmodule Mix.Tasks.ForgeAbi.GenErrorCode do
  @moduledoc """
  Generate error code
  """
  @output_folder Path.join(File.cwd!(), "priv")
  @output_summary_file Path.join(@output_folder, "error.md")
  @input_file Path.join(File.cwd!(), "lib/protobuf/status_code.yml")

  def write_error_files do
    parsed_file = parse_error_yml()
    write_to_summary("# Status Code\n\n")

    for {code_name, info} <- parsed_file do
      prepare_for_code(code_name)

      case is_binary(info) do
        true -> handle_default_code(code_name, info)
        false -> handle_tx_codes(info, code_name)
      end
    end
  end

  defp handle_default_code(code_name, info) do
    write_to_summary("#{info}\n\n")
    File.write(Path.join(@output_folder, "error_code/#{code_name}/default.md"), "#{info}")
  end

  defp handle_tx_codes(info, code_name) do
    for {tx_name, tx_msg} <- info, do: handle_tx_code(code_name, tx_name, tx_msg)
  end

  defp handle_tx_code(code_name, tx_name, tx_msg) do
    single_file = Path.join(@output_folder, "error_code/#{code_name}/#{tx_name}.md")

    File.write(single_file, "#{tx_msg}")
    write_to_summary("### #{tx_name}\n\n")
    write_to_summary("#{tx_msg}\n\n")
  end

  defp prepare_for_code(code_name) do
    write_to_summary("## #{code_name}\n\n")
    File.mkdir_p(Path.join(@output_folder, "error_code/#{code_name}"))
  end

  defp parse_error_yml do
    case YamlElixir.read_from_file(@input_file) do
      {:ok, file} -> file
      {:error, _} -> IO.puts("Fail to parse the status_code.yml file.")
    end
  end

  defp write_to_summary(content) do
    File.write(@output_summary_file, content, [:append])
  end

  def run(_argv) do
    write_error_files()
  end
end
