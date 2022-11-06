
# oficial
# https://non-contradiction.github.io/JuliaCall/index.html

# install.packages(c('JuliaCall'), dependencies = TRUE) 
library(JuliaCall)

julia <- julia_setup()

#> Julia version 1.7.2 at location /Applications/Julia-1.7.app/Contents/Resources/julia/bin will be used.
#> Loading setup script for JuliaCall...
#> Finish loading setup script for JuliaCall.

## If you want to use `Julia` at a specific location, you could do the following:
## julia_setup(JULIA_HOME = "the folder that contains Julia binary").
## You can also set JULIA_HOME in command line environment or use `options(...)`.

## Different ways of using Julia to calculate sqrt(2)

julia$command("a = sqrt(2);"); julia$eval("a")
julia_command("a = sqrt(2);"); julia_eval("a")
julia_eval("sqrt(2)")
julia_call("sqrt", 2)
julia_eval("sqrt")(2)
julia_assign("x", sqrt(2)); julia_eval("x")
julia_assign("rsqrt", sqrt); julia_call("rsqrt", 2)
2 %>J% sqrt

## You can use `julia$exists` as `exists` in R to test
## whether a function or name exists in Julia or not

julia_exists("sqrt")
julia_exists("c")

## Functions related to installing and using Julia packages

julia_install_package_if_needed("Optim")
julia_installed_package("Optim")
julia_library("Optim")

## help
julia_help("sqrt")

