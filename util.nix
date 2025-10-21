{
  toImports = basedir: modules: map (module: basedir + "/${module}.nix") modules;
}
