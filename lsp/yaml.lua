return {
  cmd = {
    "yaml-language-server",
    "--stdio",
  },
  filetypes = {
    "yaml",
  },
  root_markers = { ".git" },
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "api.yaml",
        ["https://json.schemastore.org/sqlc-2.0.json"] = "sqlc.yaml",
      },
    },
  },
}
