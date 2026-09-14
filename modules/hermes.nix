{ config, pkgs, inputs, ... }:

{
  
  services.hermes-agent = {
    enable = true;

    # ── Declarative config → renders to cli-config.yaml ──
    config = {
  model = "custom:local-ollama/llama3.1";  # flat string: "provider/model"

  custom_providers = [
    {
      name = "local-ollama";
      base_url = "http://localhost:11434/v1";
      api_key = "";  # Ollama doesn't need one
    }
  ];

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
    # ── Secrets (NEVER put API keys directly in this file) ──
    environmentFiles = [
      "/etc/hermes/hermes.env"
    ];
  };
}