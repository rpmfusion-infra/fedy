#!/bin/bash

CACHEDIR="/var/cache/fedy/jdk"

if [[ "$(uname -m)" = "x86_64" ]]; then
    ARCH="x64"
else
    ARCH="x86"
fi

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget $(wget "http://www.oracle.com/technetwork/java/javase/downloads/index.html" -O - | tr ' ' '\n' | grep "/technetwork/java/javase/downloads/jdk8" | head -n 1 | cut -d\" -f 2 | sed -e 's/^/http:\/\/www.oracle.com/') -O - | grep "Linux ${ARCH}" | grep ".rpm" | cut -d\" -f 12 | grep -v demos | head -n 1)
FILE=${URL##*/}

wget --header "Cookie: oraclelicense=a" -c "$URL" -O "$FILE"

if [[ -f "$FILE" ]]; then
    dnf -y install "$FILE"
else
    exit 1
fi

mkdir -p /usr/lib/jvm /usr/lib/jvm-exports
alternatives --install /usr/bin/java java /usr/java/latest/bin/java 2000000 \
--slave /usr/lib/jvm/jre jre /usr/java/latest/jre \
--slave /usr/lib/jvm-exports/jre jre_exports /usr/java/latest/jre/lib \
--slave /usr/bin/keytool keytool /usr/java/latest/jre/bin/keytool \
--slave /usr/bin/orbd orbd /usr/java/latest/jre/bin/orbd \
--slave /usr/bin/pack200 pack200 /usr/java/latest/jre/bin/pack200 \
--slave /usr/bin/rmid rmid /usr/java/latest/jre/bin/rmid \
--slave /usr/bin/rmiregistry rmiregistry /usr/java/latest/jre/bin/rmiregistry \
--slave /usr/bin/servertool servertool /usr/java/latest/jre/bin/servertool \
--slave /usr/bin/tnameserv tnameserv /usr/java/latest/jre/bin/tnameserv \
--slave /usr/bin/unpack200 unpack200 /usr/java/latest/jre/bin/unpack200 \
--slave /usr/share/man/man1/java.1 java.1 /usr/java/latest/man/man1/java.1 \
--slave /usr/share/man/man1/keytool.1 keytool.1 /usr/java/latest/man/man1/keytool.1 \
--slave /usr/share/man/man1/orbd.1 orbd.1 /usr/java/latest/man/man1/orbd.1 \
--slave /usr/share/man/man1/pack200.1 pack200.1 /usr/java/latest/man/man1/pack200.1 \
--slave /usr/share/man/man1/rmid.1.gz rmid.1 /usr/java/latest/man/man1/rmid.1 \
--slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 /usr/java/latest/man/man1/rmiregistry.1 \
--slave /usr/share/man/man1/servertool.1 servertool.1 /usr/java/latest/man/man1/servertool.1 \
--slave /usr/share/man/man1/tnameserv.1 tnameserv.1 /usr/java/latest/man/man1/tnameserv.1 \
--slave /usr/share/man/man1/unpack200.1 unpack200.1 /usr/java/latest/man/man1/unpack200.1
alternatives --auto java
alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 2000000 \
--slave /usr/lib/jvm/java java_sdk /usr/java/latest \
--slave /usr/lib/jvm-exports/java java_sdk_exports /usr/java/latest/lib \
--slave /usr/bin/appletviewer appletviewer /usr/java/latest/bin/appletviewer \
--slave /usr/bin/apt apt /usr/java/latest/bin/apt \
--slave /usr/bin/extcheck extcheck /usr/java/latest/bin/extcheck \
--slave /usr/bin/jar jar /usr/java/latest/bin/jar \
--slave /usr/bin/jarsigner jarsigner /usr/java/latest/bin/jarsigner \
--slave /usr/bin/javadoc javadoc /usr/java/latest/bin/javadoc \
--slave /usr/bin/javah javah /usr/java/latest/bin/javah \
--slave /usr/bin/javap javap /usr/java/latest/bin/javap \
--slave /usr/bin/jconsole jconsole /usr/java/latest/bin/jconsole \
--slave /usr/bin/jdb jdb /usr/java/latest/bin/jdb \
--slave /usr/bin/jhat jhat /usr/java/latest/bin/jhat \
--slave /usr/bin/jinfo jinfo /usr/java/latest/bin/jinfo \
--slave /usr/bin/jmap jmap /usr/java/latest/bin/jmap \
--slave /usr/bin/jps jps /usr/java/latest/bin/jps \
--slave /usr/bin/jrunscript jrunscript /usr/java/latest/bin/jrunscript \
--slave /usr/bin/jsadebugd jsadebugd /usr/java/latest/bin/jsadebugd \
--slave /usr/bin/jstack jstack /usr/java/latest/bin/jstack \
--slave /usr/bin/jstat jstat /usr/java/latest/bin/jstat \
--slave /usr/bin/jstatd jstatd /usr/java/latest/bin/jstatd \
--slave /usr/bin/native2ascii native2ascii /usr/java/latest/bin/native2ascii \
--slave /usr/bin/policytool policytool /usr/java/latest/bin/policytool \
--slave /usr/bin/rmic rmic /usr/java/latest/bin/rmic \
--slave /usr/bin/schemagen schemagen /usr/java/latest/bin/schemagen \
--slave /usr/bin/serialver serialver /usr/java/latest/bin/serialver \
--slave /usr/bin/wsgen wsgen /usr/java/latest/bin/wsgen \
--slave /usr/bin/wsimport wsimport /usr/java/latest/bin/wsimport \
--slave /usr/bin/xjc xjc /usr/java/latest/bin/xjc \
--slave /usr/share/man/man1/appletviewer.1 appletviewer.1 /usr/java/latest/man/man1/appletviewer.1 \
--slave /usr/share/man/man1/apt.1 apt.1 /usr/java/latest/man/man1/apt.1 \
--slave /usr/share/man/man1/extcheck.1 extcheck.1 /usr/java/latest/man/man1/extcheck.1 \
--slave /usr/share/man/man1/jar.1 jar.1 /usr/java/latest/man/man1/jar.1 \
--slave /usr/share/man/man1/jarsigner.1 jarsigner.1 /usr/java/latest/man/man1/jarsigner.1 \
--slave /usr/share/man/man1/javac.1 javac.1 /usr/java/latest/man/man1/javac.1 \
--slave /usr/share/man/man1/javadoc.1 javadoc.1 /usr/java/latest/man/man1/javadoc.1 \
--slave /usr/share/man/man1/javah.1 javah.1 /usr/java/latest/man/man1/javah.1 \
--slave /usr/share/man/man1/javap.1 javap.1 /usr/java/latest/man/man1/javap.1 \
--slave /usr/share/man/man1/jconsole.1 jconsole.1 /usr/java/latest/man/man1/jconsole.1 \
--slave /usr/share/man/man1/jdb.1 jdb.1 /usr/java/latest/man/man1/jdb.1 \
--slave /usr/share/man/man1/jhat.1 jhat.1 /usr/java/latest/man/man1/jhat.1 \
--slave /usr/share/man/man1/jinfo.1 jinfo.1 /usr/java/latest/man/man1/jinfo.1 \
--slave /usr/share/man/man1/jmap.1 jmap.1 /usr/java/latest/man/man1/jmap.1 \
--slave /usr/share/man/man1/jps.1 jps.1 /usr/java/latest/man/man1/jps.1 \
--slave /usr/share/man/man1/jrunscript.1 jrunscript.1 /usr/java/latest/man/man1/jrunscript.1 \
--slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 /usr/java/latest/man/man1/jsadebugd.1 \
--slave /usr/share/man/man1/jstack.1 jstack.1 /usr/java/latest/man/man1/jstack.1 \
--slave /usr/share/man/man1/jstat.1 jstat.1 /usr/java/latest/man/man1/jstat.1 \
--slave /usr/share/man/man1/jstatd.1 jstatd.1 /usr/java/latest/man/man1/jstatd.1 \
--slave /usr/share/man/man1/native2ascii.1 native2ascii.1 /usr/java/latest/man/man1/native2ascii.1 \
--slave /usr/share/man/man1/policytool.1 policytool.1 /usr/java/latest/man/man1/policytool.1 \
--slave /usr/share/man/man1/rmic.1 rmic.1 /usr/java/latest/man/man1/rmic.1 \
--slave /usr/share/man/man1/schemagen.1 schemagen.1 /usr/java/latest/man/man1/schemagen.1 \
--slave /usr/share/man/man1/serialver.1 serialver.1 /usr/java/latest/man/man1/serialver.1 \
--slave /usr/share/man/man1/wsgen.1 wsgen.1 /usr/java/latest/man/man1/wsgen.1 \
--slave /usr/share/man/man1/wsimport.1 wsimport.1 /usr/java/latest/man/man1/wsimport.1 \
--slave /usr/share/man/man1/xjc.1 xjc.1 /usr/java/latest/man/man1/xjc.1
alternatives --auto javac

if [[ "$arch" = "x86" ]]; then
    alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/latest/lib/i386/libnpjp2.so 2000000
    alternatives --auto libjavaplugin.so
elif [[ "$arch" = "x64" ]]; then
    alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/lib/amd64/libnpjp2.so 2000000
    alternatives --auto libjavaplugin.so.x86_64
fi
