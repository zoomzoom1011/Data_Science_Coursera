Next Word Predict Presentation
========================================================
author: Zoom
date: March, 26, 2020
autosize: true

Build a model to predict next word
========================================================

In this project, I 

- Analyse the data from the blog, news and twitter

- Save the N-grams database from the analysis by NLP models

- Use different methods to save the database 

- Tune the sample ratio for data collection & running speed 


Algorithm build
========================================================

- Download the twitter, blog and news data if not existed

- The dataset is cleaned by removing numbers, punctuation, white space, stop words, signs and converted to lower case

- sample from the dataset to reduce the size of N-gram database

- use RWeka to form from 6-gram to uni-gram database

- drop the elements which have least frequent N-grams


Shiny App interface
========================================================

- An input box is provided for users to input words and sentences

- Another box is designed to show all the input content

- Automatically detects the lastest four words and find out a most frequent following word

- Interacts with N-gram from N = 5 to N =2

- If no match is found, output "it" by default



App evaluation 
========================================================

- Almost instant reponse

- Less memory required

- Application located in: <https://zoomzoom1011.shinyapps.io/Data_Science_Capstone_Final/>

- The code will be updated later with more features
