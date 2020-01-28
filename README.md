# SASmode, an interactive SAS plugin for Vim

## Features

## Installation

Prior to installing SASmode, ensure Vim and Python are properly configured.  SASmode will have no effect without proper Python 3 support for Vim.

### Python version

SASmode depends on Python 3.6.5 or higher.

To check if Vim has built-in Python 3 support, run the following command within Vim (should return a 1): `:echo has("python3")`
Check Python version: `python3 import sys; print(sys.version)`

### Python modules

   * `saspy` is required for all functionality. 
   * `pywin32` is required for accessing SAS Grid
   * `pandas` enables optional functionality
   
To install Python modules (using `pip`): `pip install --user saspy`

### Import SASmode

#### Using Vundle
```
Plugin 'https://github.com/little-boots/SASMode', {'name': 'SASmode'}
```

#### Manually
```
cd ~/.vim
% git clone 'https://github.com/little-boots/SASMode' 
```
