local jdtls = require("jdtls")

local root_markers = { "pom.xml", "gradlew", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local config = {
  cmd = { "jdtls" },
  root_dir = root_dir,
}

jdtls.start_or_attach(config)
