# Command line to take the input
import argparse
import sys
import pandas as pd
import collections
import json


## Defining function for the processing
def parsing_json(df,k1,k2,k3):
    main_dict=collections.defaultdict(dict)
#        print("k1",k1)
#        print("k2",k2)
#        print("k3",k3)
    group_key_1=df.groupby(k1)
## 1st  group to form groups as per the first key given    
    for item in group_key_1:
        df_temp=pd.DataFrame(list(item)[1])
        group_key_2=df_temp.groupby(k2)
## 2nd group to form groups as per the second key given    
        for items in group_key_2:
            df_temp1=pd.DataFrame(list(items)[1])
            df_temp1=df_temp1.reset_index()
            #print(df_temp1)
## Analysing each group to add into temp dict
            for i in range(df_temp1[k1].count()):
                ky1=df_temp1[k1][i]
                ky2=df_temp1[k2][i]
                ky3=df_temp1[k3][i]
                ky4=df_temp1["amount"][i]
#               print(ky1)
#               print(ky2)
#               print(ky3)
                temp_dict=collections.defaultdict(dict)
                temp_dict[ky2][ky3]=[{"amount": ky4}]
                if ky1 in main_dict:
                    main_dict[ky1].update(temp_dict)
                else:
                    main_dict[ky1]=temp_dict
## Writing down the output on to the screen with required indentation  
    sys.stdout.write(json.dumps(main_dict, ensure_ascii=False, indent=4))

    
    
        
        
parser=argparse.ArgumentParser(description='For the input')
parser.add_argument('input1',type=str,help="give first input from [currency,country,city]")
parser.add_argument('input2',type=str,help="give second input from [currency,country,city]")
parser.add_argument('input3',type=str,help="give third input from [currency,country,city]")
args=parser.parse_args()
key_1=args.input1
key_2=args.input2
key_3=args.input3

if (key_1 != key_2 !=key_3):
    ## Reading the file, the file has been hard coded and is present in thw working directory
    try:
        df=pd.read_json(sys.stdin)
        parsing_json(df,key_1,key_2,key_3)
    except:
        sys.stderr.write("There is no file present or error or processing the file ")
else:
    print("please check the inputs, they should be unique at each level")
------------------------------------




























































        
        
    
    
    








    
    
