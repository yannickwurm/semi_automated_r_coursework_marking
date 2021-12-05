# WARNING

need to change logic at beginning to use the other download - see #2

# Do the marking within git/code directory 

Download all submissions, rename overall dear to submissions, raname each student dir to only be studnet number

```
mv BIO773-Downloaded_directory_with_long_names submissions
# keep only numbers
rename -e 's/([A-z_ ]*)([0-9]+)(_[A-z]+)/\2/'  *
```


Then I ran marking code on each one withing a reporting environment, as part of `mark_text_shortener.Rmd`:

```bash 
ls submissions | parallel "cd submissions/{}; ln -s ../../mark_text_shortener.Rmd"
ls submissions | parallel "cd submissions/{}; ln -s ../../test_text_shortener.R"

ls submissions | parallel -j 1 -t -q --workdir submissions/{} Rscript -e 'library(knitr); output = knit("mark_text_shortener.Rmd"); render(output, output_format = "html_document")'

```

Running typically requires installing all the R libraries that students depend on. 

I had to check for "Error"  `Execution halted` messages that occurred when students had superfluous commands in their code (e.g. calling variable that don't exist, etc)


(This creates a detailed html doc for each student, highlighting which tests failed and which worked - thanks to R's testthat unit testing package)



To populate my excel with the students marks:
```
mkdir marks
egrep "were unsuccessfu" submissions/*/*.md | sed 's/submissions\///' | sed 's/_assignsubmission_file_\/mark_text_shortener.md:I /: /'  > marks/test_per_student.tsv
grep "issues with style" submissions/*/*.md | ruby -pe 'gsub(/[A-z.:,.\/]+/, "")' | ruby -pe 'gsub(/ +/, " ")' | cut  -f1,2 > marks/lint_issues_per_student.tsv

```

For sharing these results with students, I did: 

```
ls submissions |  parallel -j 1 -t "scp submissions/{}/mark_text_shortener.html ubuntu@sequenceserver.com://efs/static-sites/antgenomes.org/users/yannickwurm/tmp/feedback/2021_{}.html"
```


Additionally, took notes in `notes_for_getting_things_to_load`. Summary of marks in marks_summary.xlsx








