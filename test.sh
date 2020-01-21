deleted_or_renamed=$(git diff --no-commit-id --name-only --diff-filter DR origin/master | grep  -i .md$ | grep -v -i _sidebar.md | grep -v -i ISSUE_TEMPLATE | wc -l || true)

if [ $deleted_or_renamed -eq 0 ]
then
    files=$(git diff --no-commit-id --name-only --diff-filter AM master | grep  -i .md$ | grep -v -i _sidebar.md | grep -v -i ISSUE_TEMPLATE|| true)
else
    files=$(find . -name \*.md ! -iname _sidebar.md ! -ipath \*/ISSUE_TEMPLATE/\*.md|| true)
fi

for file in $files; do
    markdown-link-check -q -c .github/markdown-link-check-config.json $file
done