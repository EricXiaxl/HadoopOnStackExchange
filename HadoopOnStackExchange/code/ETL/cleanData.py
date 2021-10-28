
# coding: utf-8

import glob;
import pandas;
import re;

originalDataPath = 'assignment/data/original'
cleanedDataPath = 'assignment/data/cleaned';

allFiles = glob.glob(originalDataPath + "/*.csv");

for finalFilePath in allFiles:
    filename = finalFilePath.split('/')[3];
    rf = pandas.read_csv(finalFilePath);
    rf['Body'] = rf['Body'].apply(lambda body: re.sub('<.*?>|\\t*\\r*\\n*\\s+',' ',body));
    rf['Title'] = rf['Title'].apply(lambda title: re.sub('<.*?>|\\t*\\r*\\n*\\s+',' ',title));
    rf.to_csv(cleanedDataPath+'/cleaned_'+filename,index=False);

