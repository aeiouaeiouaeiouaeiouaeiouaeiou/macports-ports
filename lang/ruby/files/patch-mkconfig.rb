--- ../ruby-1.8.1.orig/mkconfig.rb	Mon Aug  4 13:43:00 2003
+++ mkconfig.rb	Thu Apr  1 17:42:28 2004
@@ -111,6 +111,14 @@
   CONFIG["archdir"] = "$(rubylibdir)/$(arch)"
   CONFIG["sitelibdir"] = "$(sitedir)/$(ruby_version)"
   CONFIG["sitearchdir"] = "$(sitelibdir)/$(sitearch)"
+  CONFIG["vendorlibdir"] = "$(vendordir)/$(ruby_version)"
+  CONFIG["vendorarchdir"] = "$(vendorlibdir)/$(vendorarch)"
+  if defined?(VENDOR_SPECIFIC) && VENDOR_SPECIFIC
+	CONFIG["sitearch"] = CONFIG["vendorarch"]
+	CONFIG["sitedir"] = CONFIG["vendordir"]
+	CONFIG["sitelibdir"] = CONFIG["vendorlibdir"]
+	CONFIG["sitearchdir"] = CONFIG["vendorarchdir"]
+  end
   CONFIG["compile_dir"] = "#{Dir.pwd}"
   MAKEFILE_CONFIG = {}
   CONFIG.each{|k,v| MAKEFILE_CONFIG[k] = v.dup}
