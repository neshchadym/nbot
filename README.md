# Nbot

## Description

Telegram bot

## Bot Link

You can access the bot via this link: [t.me/neshchadym_bot]

## Installation Instructions

1. **Clone the repository**: First, you need to clone the repository to your local machine. You can do this with the following command:
    ```bash
    git clone https://github.com/neshchadym/nbot.git
    ```

2. **Navigate to the project directory**: Use the `cd` command to navigate to the directory of the project:
    ```bash
    cd nbot
    ```

3. **Install the dependencies**: Your project is written in Go, so you will need to download the dependencies. You can do this with the `go mod download` command.

4. **Build the project**: You can build the project using the `go build` command. If you need to add linker flags, you can do so with the `-ldflags` option. For example:
    ```bash
    go build -ldflags "-X github.com/neshchadym/nbot/cmd.appVersion=v1.0.1"
    ```

5. **Set up environment variables**: Your project uses the `TELE_TOKEN` environment variable. You can set this in your terminal session with the `export` command on Unix-like systems (Linux, MacOS) or the `set` command on Windows. For example:
    ```bash
    export TELE_TOKEN=your_token_here
    ```
    Replace `"your_token_here"` with your actual token.

6. **Run the project**: Finally, you can run the project. If you've built an executable, you can run it directly from the command line.

## Command Examples

Provide examples of how to use the commands in your bot here. For example:

- `/start`: Starts the bot and provides a welcome message.
