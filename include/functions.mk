define debian-control-file
echo "Package: $2"         >  $1
echo "Version: $3"         >> $1
echo "Section: custom"     >> $1
echo "Priority: optional"  >> $1
echo "Architecture: all"   >> $1
echo "Essential: no"       >> $1
echo "Installed-Size: 256" >> $1
echo "Maintainer: zewo.io" >> $1
echo "Description: $4"     >> $1
endef

define git-checkout
git clone --quiet $1 $3
git -C $3 checkout --quiet $2
endef
