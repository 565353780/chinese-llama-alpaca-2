lr=1e-4
lora_rank=64
lora_alpha=128
lora_trainable="q_proj,v_proj,k_proj,o_proj,gate_proj,down_proj,up_proj"
modules_to_save="embed_tokens,lm_head"
lora_dropout=0.05
seed=2023

pretrained_model=/home/chli/github/textgen/models/chinese-alpaca-2-7b/
chinese_tokenizer_path=/home/chli/github/textgen/models/chinese-alpaca-2-7b/
dataset_dir=/home/chli/dataset/test1/train/
per_device_train_batch_size=1
per_device_eval_batch_size=4
gradient_accumulation_steps=8
output_dir=./output/
validation_file=/home/chli/dataset/test1/val/data_test1_val.json

deepspeed_config_file=ds_zero2_no_offload.json

cd ../cla2/scripts/training/
torchrun --nnodes 1 --nproc_per_node 1 run_clm_sft_with_peft.py \
	--deepspeed ${deepspeed_config_file} \
	--model_name_or_path ${pretrained_model} \
	--tokenizer_name_or_path ${chinese_tokenizer_path} \
	--dataset_dir ${dataset_dir} \
	--validation_split_percentage 0.001 \
	--per_device_train_batch_size ${per_device_train_batch_size} \
	--per_device_eval_batch_size ${per_device_eval_batch_size} \
	--do_train \
	--do_eval \
	--seed ${seed} \
	--fp16 \
	--num_train_epochs 1 \
	--lr_scheduler_type cosine \
	--learning_rate ${lr} \
	--warmup_ratio 0.03 \
	--weight_decay 0 \
	--logging_strategy steps \
	--logging_steps 10 \
	--save_strategy steps \
	--save_total_limit 3 \
	--evaluation_strategy steps \
	--eval_steps 100 \
	--save_steps 200 \
	--gradient_accumulation_steps ${gradient_accumulation_steps} \
	--preprocessing_num_workers 8 \
	--max_seq_length 1024 \
	--output_dir ${output_dir} \
	--overwrite_output_dir \
	--ddp_timeout 30000 \
	--logging_first_step True \
	--lora_rank ${lora_rank} \
	--lora_alpha ${lora_alpha} \
	--trainable ${lora_trainable} \
	--modules_to_save ${modules_to_save} \
	--lora_dropout ${lora_dropout} \
	--torch_dtype float16 \
	--validation_file ${validation_file} \
	--gradient_checkpointing \
	--ddp_find_unused_parameters False \
	--flash_attn
