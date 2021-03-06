{ stdenv, fetchurl, collectd }:
with stdenv.lib;

overrideDerivation collectd (oldAttrs: {
  name = "libcollectdclient-${collectd.version}";
  buildInputs = [ ];

  NIX_CFLAGS_COMPILE = oldAttrs.NIX_CFLAGS_COMPILE ++ [
    "-Wno-error=unused-function"
  ];

  configureFlags = oldAttrs.configureFlags ++ [
    "--disable-daemon"
    "--disable-all-plugins"
  ];

  postInstall = "rm -rf $out/{bin,etc,sbin,share}";

}) // {
  meta = with stdenv.lib; {
    description = "C Library for collectd, a daemon which collects system performance statistics periodically";
    homepage = http://collectd.org;
    license = licenses.gpl2;
    platforms = platforms.linux; # TODO: collectd may be linux but the C client may be more portable?
    maintainers = [ maintainers.sheenobu maintainers.bjornfor ];
  };
}
