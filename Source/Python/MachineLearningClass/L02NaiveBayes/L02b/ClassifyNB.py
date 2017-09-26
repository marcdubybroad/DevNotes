def classify(features_train, labels_train):   
    ### import the sklearn module for GaussianNB
    ### create classifier
    ### fit the classifier on the training features and labels
    ### return the fit classifier
    
        
    ### your code goes here!
    # import library
    from sklearn.naive_bayes import GaussianNB
    
    # create the fitter
    clf = GaussianNB()
    
    # train/fit the data
    clf.fit(features_train, labels_train)
    
    # return
    return clf



