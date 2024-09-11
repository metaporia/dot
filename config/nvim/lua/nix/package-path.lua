
package.path = --vim.fn.expand("$HOME")
	--.. "/.luarocks/share/lua/5.1/?/init.lua"
  -- will need to be updated `nix-locate -p 'magick' init.lua`
	"/nix/store/c922vrxr2rapqhs8y8j95i7aaf2sy4jg-luajit2.1-magick-1.6.0-1/share/lua/5.1/?/init.lua" .. ";" .. package.path
package.path =
	-- vim.fn expand("$HOME")
	--"/.luarocks/share/lua/5.1/?.lua"
	"/nix/store/c922vrxr2rapqhs8y8j95i7aaf2sy4jg-luajit2.1-magick-1.6.0-1/share/lua/5.1/?.lua" .. ";" .. package.path

