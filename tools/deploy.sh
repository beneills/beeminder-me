#s3cmd put --recursive ../_site/* s3://www.beneills.com/showcase/
git push origin master gh-pages
echo "Finished upload!"
