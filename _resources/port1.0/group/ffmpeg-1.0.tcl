# -*- coding: utf-8; mode: tcl; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- vim:fenc=utf-8:ft=tcl:et:sw=4:ts=4:sts=4
#
# This PortGroup allows building with a specific version of ffmpeg.
#
# Usage:
#
#   PortGroup               ffmpeg 1.0
#   ffmpeg.version          version

namespace eval ffmpeg { }

options ffmpeg.version
default ffmpeg.version 8

proc ffmpeg::configure_build {} {
    global cmake.prefix_path prefix
    depends_lib-append          port:ffmpeg[option ffmpeg.version]
    configure.pkg_config_path-prepend \
                                ${prefix}/libexec/ffmpeg[option ffmpeg.version]/lib/pkgconfig
    configure.cppflags-prepend  -I${prefix}/libexec/ffmpeg[option ffmpeg.version]/include
    configure.ldflags-prepend   -L${prefix}/libexec/ffmpeg[option ffmpeg.version]/lib
    if {[info exists cmake.prefix_path]} {
        cmake.prefix_path-prepend   ${prefix}/libexec/ffmpeg[option ffmpeg.version]
    }
}

port::register_callback ffmpeg::configure_build
