key=$1
op=$2
oparg=$3
index=$4

declare -A key_lengths=( ["12-zipf"]="32" ["62-zipf"]="32" ["100-zipf"]="32" ["220-zipf"]="32" ["alpha-numeric-zipf"]="32" ["220-zipf"]="32" ["customername"]="18" ["ERP"]="19" ["wikititle"]="128" ["wikiurl"]="128" ["yago"]="128" )
declare -A key_types=( ["12-zipf"]="synthetic32B" ["62-zipf"]="synthetic32B" ["100-zipf"]="synthetic32B" ["220-zipf"]="synthetic32B" ["alpha-numeric-zipf"]="synthetic32B" ["220-zipf"]="synthetic32B" ["customername"]="string" ["ERP"]="string" ["wikititle"]="string" ["wikiurl"]="string" ["yago"]="string" )
declare -A exe_types=( ["12-zipf"]="random" ["62-zipf"]="random" ["100-zipf"]="random" ["220-zipf"]="random" ["alpha-numeric-zipf"]="random" ["220-zipf"]="random" ["customername"]="string" ["ERP"]="string" ["wikititle"]="string" ["wikiurl"]="string" ["yago"]="string" )

key_length=${key_lengths[${key}]}
key_type=${key_types[${key}]}
exe_type=${exe_types[${key}]}

exe="./bin/${key_length}B/workload_${exe_type}_oltp"


workload_dir="./workload_dir"
init_file="${workload_dir}/workload_all_${key_type}_${key}_load.dat"
mod_file="${workload_dir}/workload_all_${key_type}_${key}_mod.dat"
txn_file="${workload_dir}/workload_${op}_${oparg}_${key_type}_${key}_txn.dat"

cmd="numactl --cpunodebind 1 --membind 1 ${exe} ${init_file} ${mod_file} ${txn_file} ${index}"

eval ${cmd}

