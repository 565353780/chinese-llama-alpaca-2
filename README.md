# Chinese Llama Alpaca 2

## Setup

```bash
conda create -n cla2 python=3.11
conda activate cla2
./setup.sh
```

## Run

```bash
./run.sh
```

## Train

prepare the dataset as:

```bash
<dataset-folder>
|--train
    |--<train-dataset>.json
|--<val-dataset>.json
```

and set dataset_dir:

```bash
dataset_dir=<path-to-dataset-folder>/train/
```

```bash
./run_sft.sh
```

## Enjoy it~
