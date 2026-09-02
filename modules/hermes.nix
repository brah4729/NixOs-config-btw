{ config, pkgs, ... }:

{
  services.hermes-agent = {
    enable = true;

    # ── Declarative config → renders to cli-config.yaml ──
    config = {
      model = {
        # Cloud model (recommended as default — local models struggle with
        # multi-step tool calling that agents rely on)
        # default = "";
        # provider = "";

        # If you want to switch to a locally-hosted model via Ollama instead,
        # comment the two lines above and uncomment these:
        default = "ollama/llama3.1";
        provider = "ollama";
        base_url = "http://localhost:11434/v1";
      };

      terminal = {
        backend = "local";
        timeout = 180;
        lifetime_seconds = 300;
      };

      agent = {
        max_turns = 60;
        reasoning_effort = "medium";
      };

      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
        memory_char_limit = 2200;
      };

      toolsets = [ "all" ];
    };

    # ── MCP servers ──
    mcpServers = {
      filesystem = {
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-filesystem" "/home/e/workspace" ];
      };

      # Add more MCP servers here as you need them, e.g. github:
      # github = {
      #   command = "npx";
      #   args = [ "-y" "@modelcontextprotocol/server-github" ];
      #   env.GITHUB_PERSONAL_ACCESS_TOKEN = "\${GITHUB_TOKEN}";
      # };
    };

    # ── Secrets (NEVER put API keys directly in this file) ──
    environmentFiles = [
      "/etc/hermes/hermes.env"
    ];
  };
}