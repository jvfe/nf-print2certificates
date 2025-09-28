# nf-print2certificates

## Run the pipeline
You can run a demo with the following command:
```
nextflow run jvfe/nf-print2certificates -r main
```

If you want to provide custom names, templates and fonts you can run with:
```
nextflow run main.nf --names names.txt --template certificate_template.png --font GochiHand-Regular.ttf
```

## Custom coordinates
You can also provide custom coordinates with `--x` and `--y`. In the current template, these should equate to half the width and height.

## Check the results
Check the `output` folder in the current working directory to find the certificates
