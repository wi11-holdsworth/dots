{
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.ollama-rocm ];

  services = {
    open-webui.enable = true;

    ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = [
        # small
        # keep-sorted start
        "deepseek-r1:1.5b"
        "gemma3:1b"
        "gemma3:270m"
        "gemma3:4b"
        "llama3.2:1b"
        "llama3.2:3b"
        "ministral-3:3b"
        "qwen3:0.6b"
        "qwen3:1.7b"
        "qwen3:4b"
        # keep-sorted end
        # medium
        # keep-sorted start
        "deepseek-r1:7b"
        "deepseek-r1:8b"
        "llama3.1:8b"
        "ministral-3:8b"
        "qwen3:8b"
        # keep-sorted end
        # large
        # keep-sorted start
        "deepseek-r1:14b"
        "gemma3:12b"
        "ministral-3:14b"
        "qwen3:14b"
        # keep-sorted end
      ];
    };
  };
}
