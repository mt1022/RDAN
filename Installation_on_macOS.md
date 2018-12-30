Reference: https://cran.r-project.org/doc/manuals/R-admin.html#macOS

----------------------------------

### Install newest version of gfortran and llvm + clang through
```bash
brew install llvm --with-clang
brew install gfortran
```
Add the following to `~/.bash_profile`:
```
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
 ```
Install xquartz (to visualize plots)(.dmg, https://www.xquartz.org).
Install java JDK (https://www.oracle.com/technetwork/java/javase/downloads/index.html).

### Download latest R source .tar.gz and compile
Add the following to `./config.site`:
```bash
CC=/usr/local/opt/llvm/bin/clang
OBJC=$CC
F77=/usr/local/gfortran/bin/gfortran
FC=$F77
CXX=/usr/local/opt/llvm/bin/clang++
LDFLAGS="-L/usr/local/opt/llvm/lib -L/usr/local/lib"
R_LD_LIBRARY_PATH=/usr/local/opt/llvm/lib:/usr/local/lib

JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
JAVA_CPPFLAGS="-I/${JAVA_HOME}/include -I/${JAVA_HOME}/include/darwin"
JAVA_LD_LIBRARY_PATH="${JAVA_HOME}/lib/server"
JAVA_LIBS="-L/${JAVA_HOME}/lib/server -ljvm"
```

Run `./configure` and `make`:
```bash
./configure --enable-R-framework \
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig \
DYLD_FALLBACK_LIBRARY_PATH=/usr/local/opt/llvm/lib:/usr/local/lib

make
sudo make install
```

When `make` is aborted due to errors about file not existing or permissions:
```
sudo chwon -R `whoami` .
```

To configure without xquartz:
```
./configure  --without-x --without-aqua  --enable-R-framework \
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig \
DYLD_FALLBACK_LIBRARY_PATH=/usr/local/opt/llvm/lib:/usr/local/lib
```
