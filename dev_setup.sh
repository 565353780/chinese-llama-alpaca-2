cd ..
git clone https://github.com/ymcui/Chinese-LLaMA-Alpaca-2.git cla2

cd cla2
git pull

pip install -U -r requirements.txt

pip install -U datasets scipy deepspeed einops packaging ninja
MAX_JOBS=16 pip install flash-attn --no-build-isolation
