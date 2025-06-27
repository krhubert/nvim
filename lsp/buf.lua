return {
  cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
  filetypes = { "proto" },
  root_markers = {
    "buf.yaml",
    "buf.gen.yaml",
    "buf.work.yaml",
    "buf.work.gen.yaml",
    ".git",
  },
}
