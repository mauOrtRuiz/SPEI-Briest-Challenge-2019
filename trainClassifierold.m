function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationAccuracy: a double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 22-Dec-2018 21:47:18


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable.Centroidfin_1 = inputTable.Centroidfin(:,1);
inputTable.Centroidfin_2 = inputTable.Centroidfin(:,2);
inputTable.text_contrast_1 = inputTable.text_contrast(:,1);
inputTable.text_contrast_2 = inputTable.text_contrast(:,2);
inputTable.text_homogenety_1 = inputTable.text_homogenety(:,1);
inputTable.text_homogenety_2 = inputTable.text_homogenety(:,2);

predictorNames = {'Areafin', 'back_density', 'Bback', 'BaD', 'positive_density', 'Eccenfin', 'Roundfin', 'Centroidfin_1', 'Centroidfin_2', 'Mayor_ellipsefin', 'Minor_ellipsefin', 'Orien_Anglefin', 'Perimeterfin', 'text_contrast_1', 'text_contrast_2', 'text_homogenety_1', 'text_homogenety_2', 'hValue', 'sValue', 'vValue'};
predictors = inputTable(:, predictorNames);
response = inputTable.yfitC;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', ['M' 'a' 'l' 'i' 'g' 'n' 'a' 'n' 't'; 'N' 'o' 'r' 'm' 'a' 'l' 'e' 'p' 'y'; 'l' 'y' 'm' 'p' 'h' 'o' 'c' 'y' 't']);

% Create the result struct with predict function
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'Centroidfin', 'text_contrast', 'text_homogenety'})), array2table(table2array(t(:,{'Centroidfin', 'text_contrast', 'text_homogenety'})), 'VariableNames', {'Centroidfin_1', 'Centroidfin_2', 'text_contrast_1', 'text_contrast_2', 'text_homogenety_1', 'text_homogenety_2'})];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(x));
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Areafin', 'back_density', 'Bback', 'BaD', 'positive_density', 'Eccenfin', 'Roundfin', 'Mayor_ellipsefin', 'Minor_ellipsefin', 'Orien_Anglefin', 'Perimeterfin', 'hValue', 'sValue', 'vValue', 'Centroidfin', 'text_contrast', 'text_homogenety'};
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2017b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable.Centroidfin_1 = inputTable.Centroidfin(:,1);
inputTable.Centroidfin_2 = inputTable.Centroidfin(:,2);
inputTable.text_contrast_1 = inputTable.text_contrast(:,1);
inputTable.text_contrast_2 = inputTable.text_contrast(:,2);
inputTable.text_homogenety_1 = inputTable.text_homogenety(:,1);
inputTable.text_homogenety_2 = inputTable.text_homogenety(:,2);

predictorNames = {'Areafin', 'back_density', 'Bback', 'BaD', 'positive_density', 'Eccenfin', 'Roundfin', 'Centroidfin_1', 'Centroidfin_2', 'Mayor_ellipsefin', 'Minor_ellipsefin', 'Orien_Anglefin', 'Perimeterfin', 'text_contrast_1', 'text_contrast_2', 'text_homogenety_1', 'text_homogenety_2', 'hValue', 'sValue', 'vValue'};
predictors = inputTable(:, predictorNames);
response = inputTable.yfitC;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
