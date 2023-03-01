local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    --增加lombok插件支持，getter setter good bye
    "-javaagent:/root/.local/share/nvim/lsp/jdt-language-server/lombok.jar",
    "-Xbootclasspath/a:/root/.local/share/nvim/lsp/jdt-language-server/lombok.jar",
    "-jar",
    "/root/.local/share/nvim/lsp/jdt-language-server/plugin/org.eclipse.equinox.launcher_1.2.400.v20211117-0650.jar",
    "-configuration",
    "/root/.local/share/nvim/lsp/jdt-language-server/config_linux/",
    "-data",
    "/root/.local/share/nvim/lsp/jdt-language-server/workspace/folder"
  },
  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}),
  settings = {
    java = {}
  },
  init_options = {
    bundles = {}
  }
}
require('jdtls').start_or_attach(config)

