---
title: "README"
author: "Eric John Nelson"
date: "June 2, 2018"
output: html_document
---


# Getting and Cleaning Data - Course Project

##Overview
The purpose of this project is to demonstrate me ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This project required me to prepare: 

1.  A tidy data set from provided data 
2.  A link to a Github repository with my script for performing the analysis
3.  A code book (CodeBook.md) that describes the variables, the data, and any transformations or work performed
4.  A README.md which explains how all of the scripts work and how they are connected.

##Original Dataset
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##Analysis leading to tidy dataset
A single script called run_analysis.R was created to process the provided data into a tidy data set.  The script performed the steps outlined below.

1.  Downloaded the UCI_HAR_Dataset.zip file
2.  Unzipped the compressed file into the working directory
3.  Read each of the provided files into workable data tables.
4.  Merged the files together into a single data set.
      + Concatenated the three files associated with each of training and test data.
      + Row bound the training and test tables into a single data set.
5.  Created a data set containing only those measurements related to mean and standard deviation.
6.  Replaced numberic values for activities with descriptive names from the activity list.
7.  Cleaned each of the measurement column names to be readable and descriptive.
8.  Group the data set by activity and subject and aggregate the average of each measurement.
9.  Store the final tidy data set into a text file.


