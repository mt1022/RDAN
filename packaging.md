### Develop
```R
devtools::load_all()
```

### Submitting
```R
usethis::use_version()
devtools::check()
revdepcheck::revdep_check(num_workers = 4)
devtools::check_win_devel()  # takes 15~30min
devtools::submit_cran()
```
