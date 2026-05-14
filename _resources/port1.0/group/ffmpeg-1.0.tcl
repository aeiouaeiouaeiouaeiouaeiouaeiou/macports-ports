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

proc ffmpeg::set_vars {action} {
    global prefix

    set ::ffmpeg::port          port:ffmpeg${ffmpeg::version}
    set ::ffmpeg::pkgconfig     ${prefix}/libexec/ffmpeg${ffmpeg::version}/lib/pkgconfig
    set ::ffmpeg::cppflags      -I${prefix}/libexec/ffmpeg${ffmpeg::version}/include
    set ::ffmpeg::ldflags       -L${prefix}/libexec/ffmpeg${ffmpeg::version}/lib
    set ::ffmpeg::prefix        ${prefix}/libexec/ffmpeg${ffmpeg::version}

    depends_lib-${action}       ${ffmpeg::port}
    configure.pkg_config_path-${action} \
                                ${ffmpeg::pkgconfig}
    configure.cppflags-${action} \
                                ${ffmpeg::cppflags}
    configure.ldflags-${action} \
                                ${ffmpeg::ldflags}
    if {[info exists cmake.prefix_path]} {
        cmake.prefix_path-${action} \
                                ${ffmpeg::prefix}
    }
}

proc ffmpeg::configure_build {} {
    ffmpeg::set_vars        delete
    set ffmpeg::version     [option ffmpeg.version]
    ffmpeg::set_vars        prepend
}

proc ffmpeg::version_proc {option action args} {
    if {${action} ne "set"} return
    ffmpeg::configure_build
}

port::register_callback ffmpeg::configure_build
option_proc ffmpeg.version ffmpeg::version_proc

set ffmpeg::version [option ffmpeg.version]
ffmpeg::configure_build
