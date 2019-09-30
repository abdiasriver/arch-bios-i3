#!/bin/bash
# inicio del script para enviar al source blog y a abdiasriver.github.io
#sin borrar .git de la carpeta public

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
#actualizar todo local y nube
#git checkout master && git pull
# primero enviara todo a blog.
git add -A
# Commit changes.
msg="Actualizado el `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push -u origin master

# Generador del sitio con vuepress
yarn build
# Entrar a la carpeta dist igual a abdiasriver.github.io
cd dist
# Agregar cambios.
git add -A

# Comentar los cambios.
msg="Actualizado `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push
# remove all docs except git
shopt -s extglob
GLOBIGNORE=.:..
rm -rf !(.git)
# Come Back blog
cd ..

# fin del script
