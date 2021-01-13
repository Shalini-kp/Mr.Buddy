import pandas as pd
filename="whatsApp_chat.txt"
df=pd.read_csv(filename,header=None,error_bad_lines=False,encoding='utf8')
df= df.drop(0)
df.columns=['Date', 'Chat']
Message= df["Chat"].str.split("]", n = 1, expand = True)
df['Date']=df['Date'].str.replace(",","")
df['Date']=df['Date'].str.replace("[","")
df['Time']=Message[0]
df['Content']=Message[1]
Message1= df["Content"].str.split(":", n = 1, expand = True)
df['Content']=Message1[1]
df['From']=Message1[0]
df=df.drop(columns=['Chat'])
df['Content']=df['Content'].str.lower()
df['Content'] = df['Content'].str.replace('‎GIF omitted','MediaShared')
df['Content'] = df['Content'].str.replace('‎video omitted','MediaShared')
df['Content'] = df['Content'].str.replace('sticker omitted','MediaShared')
df['Content'] = df['Content'].str.replace('‎image omitted','MediaShared')
df['Content'] = df['Content'].str.replace('this message was deleted','DeletedMsg')
df.to_csv("whatsApp_chat.csv",index=False)
print(df)