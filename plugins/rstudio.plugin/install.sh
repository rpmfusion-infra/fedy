#!/bin/bash

URL=$(wget "https://www.rstudio.com/products/rstudio/download/" -O - | tr ' ' '\n' | grep -o "http*.\?://.*rstudio.*.$(uname -m).rpm" | head -n 1)

dnf -y install "$URL"
