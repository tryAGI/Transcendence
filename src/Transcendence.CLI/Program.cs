using System.CommandLine;
using Transcendence.CLI.Commands;

var rootCommand = new RootCommand(
    description: "Automates local actions providing set of tools for LLMs");
rootCommand.AddCommand(new DoCommand());

return await rootCommand.InvokeAsync(args).ConfigureAwait(false);