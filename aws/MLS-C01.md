# AWS Certified Machine Learning – Specialty (MLS-C01)

### About the Exam

This exam is one of the harder (hardest) AWS exams. If you already have some machine learning experience you should be able to pick up the concepts and follow along with ease. If not, it is going to take a lot of work and a lot of studying to get up to speed.

There are questions in the exam that have nothing to do with AWS, some have to do with ML, DL, and AI specifically. This exam does cover AWS ML services but it also covers a lot of core ML principles.

## Section - Machine Learning Fundamentals

### 02 -- Artificial Intelligence

A general term used to describe systems that appear to be intelligent and perceive their surroundings and respond in a way that seems most likely to maximize their value.

Machine Learning is a subset of AI and Deep Learning is a subset of ML.

AI -> ML -> DL

---

### 03 -- What is Machine Learning?

A subset of AI.

Linear Regression --

Logistic Regression -- Use this model when the answer is one or two outcomes. A binary output of either a one or a zero, a yes or a no, a yes yes, a hot dog or not a hot dog.

Support Vector Machines -- Can cluster information into categories.

Decision Tress -- A categorization model

These are some popular types of machine learning models.

Start off with Data. Then choose an algorithm that you think will best suit the type of data you have and the prediction that you want to make. Then take the data and the algorithm and train the model. Training the model can be computationally expensive and in the case of the example data on LinuxAcademy, training the model is trying to find the best line to fit the data.

The output of training is the model itself. Once you have the model, you can use the model with new data from the outside world to make predictions. IE -- you can make a prediction about the characteristics of a penguin, given the characteristics of a penguin that we saw before.

You can make models more useful by adding other characteristics

---

### ---

### 04 -- What Is Deep Learning?

Based upon the principles of an organic brain.

Neurons have Dendrites and Axon terminals which are responsible for passing electrical signals through our brains.

Dendrites are essentially inputs and Axon terminals are outputs. The neurons in our brain are all connected in networks or neural networks and they pass electrical signals between each other.

Data Scientists have created an artificial neuron that also has Inputs and Outputs. Inside the artificial neuron, there is an Activation Function which is just a function of code. It takes in some inputs and decided what it wants to do with the data, stores a value, and passes it on through its output.

Artificial Neurons are contained inside a network, called an Artificial Neural Network.

Neural Nets are made up of many Artificial Neural Networks that are interconnected together.

A Neural Net is a mesh network of artificial neurons, each holding an activation function. They take data from the input layer, process it through the hidden layers until it makes an inference by ending up on one of the output neurons.

## Section - Machine Learning Concepts


### 05 -- Machine Learning Lifecycle

![](../../../../media/image001.png)

Start of by collecting data. That is RAW unstructured data.

Process Data Stage

- The data collected can be in many different formats. One of the first things to do is to get the data into a single format that a computer is going to be able to understand and that the ML algo is going to be able to understand.

- Once the data is in the same format, you need to organize the data.

- Data can be organized in tables, image sets, etc

- The data has Features and a Label

- Features are what are going to be used to characterize one of the items in our list

- The Label is the thing that we're looking to try and predict in the future

- Feature Engineering -- manipulate the feature so that it better suits the training that we're trying to do.

- Standardize the data.

- Feature Reduction -- We want as much data as we can get to train the ML model but we want to reduce the amount of extraneous data that we have.

- Don't want to pass data into our model that has nothing to do with what we're trying to predict.

- Caution should be taken with this as you are trying to look for relationships between pieces of data that you have not seen before.

- Encoding -- Replacing strings with an integer value

- Formatting -- The file format you're going to use for providing the data to your ML algo.

- Record IO -- format that AWS SageMaker prefers to see

Once the data has been processed, you need to Split the data

Split Data Stage

- The data is split into Training data, Validation data (which can be optional) and Testing data.

- Can perform validation without splitting of some data specifically for it. Will learn more about this later in the course.

Train Stage

- Possibly the most important aspect of the ML lifecycle other than maybe the inference.

- This is where the model is created.

- Choose the algorithm to make the model, how the parameters are set, etc.

- When you train the algo, the algo "sees" and is directly influenced by the training data.

- The training data will directly influence the way that the model turns out.

- If you have validation data, it is used to influence the model in that the training mechanism can use the validation data to see how well it is doing in the process of training. How accurate is the model it is producing.

- If the model is not accurate or generalizing well, the training process can tweak and change some of the parameters and carry on the training process until you end up with something that works well.

- The algo does not see, does not use, and is not influenced in any way by the testing data during training.

Test Stage

- See how well the model will perform in the real world.

- Use data that is split from the original data set and set "aside" for this specific stage. This data has never been used to train the model.

- Perform inference on testing data to see how well the model fits.

- Looking to see how well our model fits, and particularly looking to see if it's Overfit.

- An overfit model would happen because the model is really good because it is able to predict anything which it has already seen in the training data.

- IE -- If it saw medical records of someone, it would know if it saw medical records of exactly these characteristics, exactly what you've originally passed in, then yes, this person is susceptible to heart disease.

- What you want to see from your model is to see if medical records for someone **like this**, not necessarily someone exactly like this, but similar -- are they susceptible to heart disease.

- With testing data, data that the model has never seen before, you can run that data through the ML model and since the data is all labeled, you should know what the answer should be and you can see whether the ML model infers or predicts correctly.

- If the data doesn't infer correctly, then it's a sign that it could be overfit in that it infers very well for its training data, but not for its testing data.

- Or possibly that it's under fit, in which case it doesn't infer very well for anything.

Deploy Stage

- An infrastructure type of stage as you now need to set up load balancing, compute power, etc.

- Host the model in execution environment according to the requirements.

- Use a batch process using your model to label large amounts of data.

- Deploy your ML model as a service. Possibly a web service endpoint that an application can use and design infrastructure to support this.

- Or create a mobile app for hot dog or not a hot dog and create infrastructure to support that.

- Designing the infrastructure is about understanding your needs in terms of what server performance do you need to actually run this model -- how many servers youre going to need to cater to the size of an audience you will have, do you need load balancing, security, etc.

Infer Stage

- Use this model in production to make inference/predictions.

- This means were taking real world, un-labeled data through the ML model and we're asking it to label for us.

After the ML cycle is complete, take the inferences and predictions and derive some business value from it.

You can also take some statistics and output from the inference so that you can start to improve the model and start a cycle of going around gradually improving the ML model.

---

### 06 - Supervised, Unsupervised, and Reinforcement

There are many different algos to use in ML and DL. It is useful to know them at a high level (and deeeeeper) to be able to categorize them so you can start to think about which algos are going to work best for your particular business problem.

![](../../../../media/image002.png)

One way of categorizing these algos is: Supervised, Unsupervised, and Reinforcement

- 3 different ways the models learn

Supervised Learning

- In the example, use data to find if people like penguins or not.

- ![](../../../../media/image003.png)

- When you get new data about a person don't know whether they like penguins or not, you can use the orginal labeled data and through ML you can try to infer or predict whether this new person likes penguins.

- The labled data is the basis of supervised learning.

- IE -- you have told the ML algo that this is what it looks like when someone likes penguins.

- That is the supervision, we're there, helping it, telling it what it looks like when someone likes penguins. So then in the future, they can predict whether someone likes penguins

- Another example of supervised learning using Numeric Data:

- Researches went out into the field and measured the heights and wegiths of various penguins.

- We used this data to create a model so that we could infer or predict, given the height of a penguin, what their weight might be

- ![](../../../../media/image004.png)

- We are giving it data so it can analyze the relationship between that data and then we can use it to predict future values.

- Example of supervised learning using Classified data for image classification:

- We have labeled data for Kiwis and Penguins, so we have lots of different pictures of Kiwis and Penguins.

- We are going to give the pictures of Kiwis to the ML model so that it can understand what a Kiwi looks like.

- We have also done the same thing with Penguins.

- These are labeled data sets that we have provided to the ML model.

- When it comes time to infer or predict, we can provide the ML Model a new picture and it can determine what it is.

- Supervised Learning is about providing data, which is being defined ahead of time, such that we can use the model to make inferences about data that hasn't been labeled.

Unsupervised Learning

- Looking for patterns in the data where we didn't necessarily see patterns in the first place.

- Can find relationships in data where we didn't know a relationship existed.

- Best used when trying to analyze data with 10's or hundreds of different dimensions.

Reinforcement Learning

![](../../../../media/image005.png)

Often used in robotics and automation.

Give a robot or mechanism an action and based on the variation of the action that it performs; we're going to give it a reward. Over time, as we reward the robot more, it will learn the specifics of the action that we're trying to get it to take.

For example: Give the robot an action of "Get Penguin" from the bucket. The robot reaches into the bucket and picks up a Kiwi. In this case, the robot gets a reward of -1 since it did not pick up a penguin. The robot has a camera and see's what is in its arms and sees that it got a reward of -1 and decides that that wasn't the right thing to do.

The robot performs the action again. It picks up another thing, we know it's a penguin, so we give the robot a reward of +1. The robot sees with its camera and sees that it got a +1 for this thing and then it will preference trying to pick that thing up again in the future.

AWS has launched Deep Racer to help learn Reinforcement Learning. You get a racecar and use a simulated environment to train a model. You give the model rewards when the racecar stays on the track and take away points or rewards when it falls off the track. Give it rewards when it goes around the track and more rewards when it increases its lap time, etc. Eventually you train up a machine learning model which you can give to a car which you can then race on a real track.

To sum up:

- Supervised Learning -- give a model pre-labeled data so the model can see patterns and draw links between the label that it's looking for on the data that's being given.

- Unsupervised Learning -- Give data to the ML model and it finds meaning and patterns in the data when we haven't asked it what it is we are looking for.

- Reinforcement Learning -- A lot of trial and error on behalf of the actual model itself. There is kind of reward to say Yes, you've done the right thing and No, you've done the wrong thing, keep on trying.

---

### 07 -- Optimization

Gradient Descent -- important concept in ML and DL

How do you know which line fits the model best?

- How does the learning mechanism know which line fits the model best?

One thing to do is to measure the distance between the model (line) and the actual observed data.

- By doing this, you get what is called, **The Sum of the Residuals**

- You then square each of these residuals so it becomes the **Sum of the Squared Residuals.**

- You square the residuals because some of the observed points are above our predicted line and some of them are below our predicted line. So, some of the differences will be negative.

- If we square each of the differences before we sum them together, we will end up with an overall positive which will equal the distance of each of these individual lines added together.

- Do this for each line that you are questioning.

- Then you can show all of the differences on a graph and we can figure out which one is the least.

- This helps us understand how the algo and the learning process will calculate the least sum of the squared residuals, which will be the line which best fits these points.

- Graph the Sum of Square Residuals vs the Slope of the Model Line

![](../../../../media/image006.png)

The points are then connected into a parabola and the ML algo's job is to find the lowest point on the parabola. We can see the bottom of the parabola on a graph but how can a ML ago?

The ML will find the bottom of the curve by finding where the curve is at a slope of 0. It is not looking for the slope of the line to be 0 but for the slope of the observation of our graph of the sum of the squares.

![](../../../../media/image007.png)

Slope of 0 = best fit the line of the model.

Again, how does the ML model find this?

- It finds a point on the curve by estimating what the slope of the model might be, and at that point it calculates the sum of squares. It then calculates the sum of squares on either side of that point as well. Then it can calculate the gradient at that point and get the slope. It knows it's not at the bottom of the line as the slope is not yet at 0. It then takes a further step in the direction the line is sloping and does the calculations again.

- It calculates the sum of squares at this new particular point for this particular slope of the model line. It discovers that the gradient at this point is still quite steep, but not quite as steep, which gives it a clue that it is going in the right direction.

- It then calculates again at the next point and keeps stepping down till it gets to the bottom of the graph.

- Every time it steps, it looks to see what the gradient of that line is and as the gradient shallows out or becomes closer to 0, it takes a smaller step.

- This is one of the most efficient ways for the algorithm to find the bottom of the graph.

![](../../../../media/image008.png)

This is Gradient Decent.

- The algo finds the gradient and descends down the path until it gets to a 0 gradient and it knows it has reached the bottom of the model.

Some key terms:

- Step

- Step size sets the **learning rate**

- **Learning rate** -> sets the initial step size the Gradient Descent will use to try to find the bottom of the curve.

- If the step size is too large, the step may miss the bottom of the graph, and this would be less efficient.

- If the step size is too small, then we have to make too many steps to get to the bottom of the graph and this is also less efficient in training our model.

- Setting the step size or setting the Gradient Descent step size is one of the tuning parameters.

(this example includes a rather simple, 2-dimensional data set)

Sometimes there might be multiple dips in the data. The lowest point we find through the Gradient Descent might not actually be the actual lowest point of the entire graph.

- Shows that ML is trial and error, try many times, see what works best for the type of affair.\
  ![](../../../../media/image009.png)

Gradient Descent is an important aspect when it comes to ML.

- It is used to optimize may different types of ML algorithms.

---

### 08 -- Regularization

What it means and does. Calculating it is beyond this course and certification. You need to understand what it is but not calculate it yourself.

Regularization through Regression. When the original model line does not fit real world data.

In the Penguin example, it happens when the model line is far more sensitive to height than it is to weight.

- With a steeper line, a small difference in height made a big difference in weight.

- When it came to inferring in the real world, it was found that this is not quite as accurate.

- By making the line shallower, we were able to regularize the relationship between height and weight.

You can't just add regularization to any data set. You wouldn't add it to your model unless you found that it wasn't performing very well.

Regularization is a mathematical process which will try and desensitize your model to a particular dimension.

- If you're dealing with a data set that has 10's or 100's of dimensions, the algo will be able to regularize the model to all of those dimensions.

2 Types of Regularization to know about:

- L1 Regularization -- uses Lasso Regression

- L2 Regularization -- uses Ridge Regression

We apply **regularization** when our model is **overfit**.

When the model fits the training data really well, but doesn't generalize to real world inference -- we say its overfit. One method to fix this is to apply regularization. Regularization is achieved through **Regression**.

---

### 09 -- Hyperparameters

Parameters that we can set on an algo as its training to become a model.

Two types:

- Hyper Parameters -- external parameters that we can set when we are initiating a training job. Dials and knobs we can turn to help influence how the training occurs.

- Examples (common across most algos):

- Learning Rate -- Determines the size of the step taken during gradient descent optimization.

- Often set between 0 and 1

- Epochs -- The number of times the algo will process the entire training data.

- It's possible to get the algo to process all the samples multiple times.

- The algo will create a more accurate model.

- Each epoch contains one or more batches.

- Each epoch should see the model get closer to the desired state.

- Common values are high numbers -- 10, 100, 1000, etc.

- The # of times that the algo will process the entire training data.

- Batch size - # of samples used to train at any one time.

- Could be all of the data (batch), a single (one) sample (stochastic), or some of your data (mini-batch).

- Often 32, 64, and 128 if not an entire batch or stochastic.

- Batch size will often be determined by the amount of data you have and the algo you're using or the infrastructure you're using.

- The exact hyperparameters that are available to you are determined by the actual algorithm that you're using.

- Parameters -- set inside the training job as the model is trained. Internal to the algo that get tuned during the training process.

---

### 10 -- Validation

When splitting the data (remember the ML Lifecycle), splitting some data into validation data is optional.

![](../../../../media/image010.png)

Cross Validation -- where we don't specifically split out validation data at all. (in the picture above the dark blue validation area would be omitted so you just split the data into Training data and Testing Data. 80% training data, 20% testing data). Leaves more data for training and testing.

With Cross Validation, we can split our training data into a number of sections and then when we train our model, we can train the model in the first 5(or so) sections of data and then perform validation with the 6^th^ section of data.

![](../../../../media/image011.png)

Once that is done, we can train again and use a different section to perform the validation. ![](../../../../media/image012.png)

Do this over and over again, each time using a different section for validation. This will give a better and better fit for our model.

Since each time you use a different section of the training data for validation, you use all of the data for training and all of the data for validation. This is called **K-Fold Cross-Validation**.

- In this example, 6-fold was used. Common values might be tenfold cross validation.

This technique can also be used to compare different algos. If you have a dataset and are not sure which algo may be best used for ML on that dataset, then you can use cross validation to try each of the algos, in turn validating from different data sets as you go through.

## Section -- Data

### 11 -- Feature Selection and Engineering

Data set used in this lesson:

![](../../../../media/image013.png)

This data set will be used to train a model to find if people like tea.

1^st^ rule of feature selection: **Remove any data that has no bearing on the outcome you're looking for.**

- A person's name has nothing to do with whether a person likes tea or not. Not relevant, we can get rid of it.

- Getting rid of data that has nothing to do with the problem were looking at, our algo can train quicker and more accurately.

- Algo will no longer look for a relationship between a person's name and whether they like tea.

- Next feature to drop is Star Sign. Star Sign does not influence whether a person likes tea or not.

- Another way to reduce the features that are in the data set is to look at the correlation between a feature and the label.

- If there is no correlation or very little, eg if there is a feature with all the same values, that feature won't help with any kind of prediction because it's the same for all of the samples, so we can remove it.

- Deciding what features to get rid of takes Domain Level Knowledge.

- In some cases, it will take trial and error to see if the decision to drop a feature is a good one or not.

Gaps and Anomalies

- Just because a piece of data is missing, doesn't necessarily mean that it is wrong. It could be a zero or a null which can be relevant for a particular data set.

- If a feature has missing values, you can either remove the feature or do something like imputation (which will be covered in another lesson).

Engineer New Features

- In this data set, we might decide there is a relationship between age and height and we might not want to pass in all of this data into our model.

- We can reduce it down a simplify it.

- Take height and divide it by age.

- It is a way to remove features from the data set so there is less data for the algo to churn through.

- Another example using this data set:

![](../../../../media/image014.png)

Trying to train a ML algo to determine whether tea has been consumed in a house at a given time.

Some feature engineering to do to provide the data to the ML algo so it is actually useful:

- Turn the data column into an Epoch and turn the values into actual points in time.

- Or look at the hour of day and run a command across this column to extract the time of day and present the info to the algo.

- Reducing amount of info and created something useful to the algo as it can compare tea consumed during hour 12 of the day and a couple of different locations.

- If it had the date, hour, and minute, it would find very little correlation between the records.

- Feature Engineering is done to **Improve Model Accuracy** and to **Speed up the training**.

- Feature Selection Tips:

- Use domain knowledge to drop irrelevant features.

- Drop features with very low correlation to the labeled data.

- Drop features with very low variance.

- Drop features with lots of missing data.

- Feature Engineering Tips:

- Simplify features and remove irrelevant information.

- Standardize your data ranges across features.

- Transform the data to suit the model/problem

- Also see: PCA (principal component analysis), Label Encoding, and One Hot Encoding

---

### 12 -- Principal Component Analysis (PCA)

How do we visualize data that has many dimensions (4+)?

![](../../../../media/image015.png)

We can't. No graph we can draw to visualize that. This is where PCA comes in. PCA enables us to draw the data in such a way that we can see relationships between the points. Looks a lot like **Unsupervised** Learning (because it is).

Used at the data level in a data preparation sense.

PCA is an unsupervised algo which can look for relationships or principle components in the data set using **Dimension Reduction**.

![](../../../../media/image016.png)

Take a picture of a 3d object, it turns into 2d but the same features are still there. It loses a dimension.

How to do this with graphs and data:

![](../../../../media/image017.png) 3-dimension graph. Do Dimension reduction to go from 3 to 2 dimensions. (going from 3 to 2 is easier for us to visualize. PCA can go from 100 dimensions down to 2 dimensions).

To perform PCA, were looking for aspects of this data which influence it the most. To do that, we find the central point of all of the data in our graph, and we do that by averaging out for finding the mean value of all of the data on Score 1, Score 2, Score 3, and finding that point in 3d space. Then extend the graph axis into the minus realm so that the mean value is centered on the origin. Then draw a box around all of these points and figure out a way of drawing a minimum bounding box around all of those points.

![](../../../../media/image018.png)

PCA will do this for us and using many more dimensions. It is a lot more complicated than just a box but in 3d space our minimum bounding box would look something like:

![](../../../../media/image019.png)

The important thing to realize is that none of the sides of the box are running parallel with Score 1, Score 2, or Score 3. The box is drawn in such a way that it is independent of the axes to try and make it as small as possible and still contain all of the points. We can see it is not a cube, it's a cuboid of some kind with each dimension of the cuboid being a different length. The longest length represents the largest variation in our data.

- To put it another way, the longest length represents the PCA or PCA #1. ![](../../../../media/image020.png)

- PC1 is not parallel to Score 3.

- The dimension of the box which is next longest is PC2 and then the shortest line is PC3.

![](../../../../media/image021.png)

- This is ordering the direction that most influences the spread of data that we have inside of our plot.

- We can then plot a graph of PC1 and PC2 and we can leave out PC3 because we are reducing the # of dimensions in our data.

- PC1 and PC2 and the most important components of our data and we leave out the 3^rd^.

- We then look at the data from the point of view of PC1 and PC2, and if we draw that on a graph it looks like:

![](../../../../media/image022.png)

PC1 is always the component that is most influential to the data. PC2 being second most, etc.

When we remove the box, we can see that there are 2 different groupings of our points. ![](../../../../media/image023.png)

We have gone from a 3-dimensional graph to a 2-dimensional graph, which gives us the ability to see relationships between these points.

Things to remember for **Principal Component Analysis (PCA)**:

- PCA is an unsupervised ML model.

- PCA is often used as a data preprocessing step.

- There can be as many PC's as features or values.

- We had 3 PC's because we had 3-dimensional data. If we had 100-dimensional data, we then have 100 PC's.

- We using PCA, you can ask the algo to produce a certain number for PC's or ask for it to produce as many PC's to as are required to cater for 80% or 90% or a certain % of the characteristics of the data.

- PC1 and PC2 can be used to plot a 2D graph so we can see the relationships between the different features.

---

### 13 -- Missing and Unbalanced Data

We have this data set:

![](../../../../media/image013.png)

Image some entries from the Age column are missing. (remove 35 and 5)

To fill in the missing data, you can calculate or **impute** a value to replace the missing data.

- You can do this by taking the mean of all other values in the column. Then you can use the mean value in place of the missing data.

- By adding in the mean value, you don't skew the data set so much that it's going to completely throw off the training model.

- Though if you left no value in there or a zero or null value, that would be significantly different from what it is now and it could have a significant impact on the algo learning.

- If there is a lot of missing data -- that would be a problem. But if there are only a few values missing, you can **impute** that data.

Another valid option is to simply remove that line or entry all together.

- With a large sample set, this won't change the outcome of training very much.

If multiple values are missing:

- Remove the feature.

- If a lot of much data is missing that average values become meaningless, we'd have a very low variance in that particular feature.

- If there is very low variance in a piece of data, there is little to no correlation with our that. This is a sign to remove that feature as it provides very little value.

Unbalanced Data

- In the data set, there are some values that look out of place.

- Alexa is 5 years old with a height of 2

- Spark is 5 years old with a height of 35

- These are potentially anomalies, but they are actually correct.

- Domain Level Knowledge is very helpful in determining whether these are actually anomalies or correct pieces of data.

- Be careful you are not removing data because it looks wrong when actually it is right.

Another example: (manufacturing data for casting of machine parts)

![](../../../../media/image024.png)

Things to do to try and combat unbalanced data:

- Source more real data

- If you get a large data set that has only 2 faults in it, the best thing to do is to try and get more data as the thing you're looking for (in this case, faults) is not represented enough in the data.

- IE you get data for a week's worth of production and it only has 2 faults. Get data from the last year and go through that so you have more faults.

- Oversample minority data

- For each genuine fault that occurs, you can multiply the number of times that you include that in your training data.

- There is no variation, so you will find it difficult to find a fault that doesn't look almost exactly like the types of fault that you've seen before on only 2 occasions.

- Synthesize data

- Uses domain level knowledge.

- What could vary in the data that doesn't include a fault.

- EG -- the width and height of the object can vary a small amount but still be fine. Take the minority data that you've got and apply some randomization to some of the values within set parameters that make sense to the data -- you then end up synthesizing data where none of it is precisely the same and the ML algo has something that approximates real world data and the training can use that data to find real faults in the real world.

- Try different types of algorithms

- Lots of different algos available, so if you have unbalanced data an d are struggling to find the rare occurrences, look for algos which specialize in finding rarities or odd ones out in your data.

- Rand Cut Forest

---

### 14 -- Label and One Hot Encoding

Using this simple data set: 3 different features

![](../../../../media/image025.png)

ML algos are mathematical constructs. They use math to find relationships within data and use those relationships to perform inferences.

When a ML algo is provided a string of data like name and country, the model can't work. We have to replace those strings with numbers. The simplest way of doing this is with **labeling coating**.

- For **labeling coating** on the name column, take each name and replace it with an integer value.

- Off the side, keep a lookup table of names to integers.

- Though for ML algos, the name column is almost always useless.

- Do the same for COUNTRY.

- Brazil = 1, Australia = 2, U.S.A = 3, U.K. = 4, etc.

- Problem with this -- Algo will look at the numbers in COUNTRY and won't understand that they're supposed to represent a country.

- Many algos will try to find a relationship and say, UK is better than Brazil because UK = 4 and Brazil = 1.

- To get around this, use **One Hot Encoding.**

**One Hot Encoding**

- Introduce new features into the data set.

- One feature for each country that you want to represent.

![](../../../../media/image026.png)

- Shows which country each sample is from, but without any numerical relationship between those countries.

- Yes, a lot more features to the data have been added, but they are 0's and 1's so they should be easy for the algo to process.

- NO RELATIONSHIP OR IMPLIED HIERACHY between the different countries.

Things to remember:

- ML algos use numbers

- Replace strings with numbers

- Use **label encoding** to replace string values with numbers

- Have external lookup to match numbers with strings.

- ML looks for patterns and relationships

- Use **one hot encoding** for categorical features

---

### 15 -- Splitting and Randomization

Training Data -- Roughly 80% of our data

- Directly influences the model

Validation Data -- Optional

- Used to tune hyperparameters

Testing Data -- Roughly 20% of data

- Used to test a complete model

![](../../../../media/image027.png)

With data collected over time, the only data used for testing is data collected at the end of the time period.

- As data is collected, there could be no relationship between Item1 and Item2 all the way down to the item at the very end of our sample period.

In the batches of data collected for image identification, in this example the testing data only contains images of Kiwis.

- Not going to be of any use for testing the capability of the model to detect penguins.

For this reason, we have to **randomize** our data.

- Randomize where the testing data is coming from, and also randomize the order of the training data.

Always randomize the data

- Even when you're unaware of data clumping.

- Some algos will shuffle data during training, but not between the training and test data sets.

- Don't simply rely on an algo shuffling data ahead of training.

---

### 16 -- RecordIO Format

Example

Training a model to classify different images of penguins or kiwis.

Have a set of different PNG image files are going to be used for training.

The process may go like:

- ML algo is spun up

- Its pointed to the first image

- It processes that image and updates its model, then gets rid of that image

- It loads the next image, processes that image, updates its model, and gets rid of that image

- And on and on and on until all the images are processed into the ML algo

Loading images individually into a ML algo takes a long time. There are better ways to go about this.

What we do is use a file format called RecordIO.

- RecordIO will contain all the PNG images in one file

When the algo goes to load all that data (PNG images) all it has to do is to point to one file.

RecordIO is used for Pipe Mode.

- Pipe Mode streams data (as opposed to "file mode")

- Pipe Mode is faster. Faster training startup times and better throughput during the training.

- Its faster because the algo and the infrastructure that the algo is sitting on doesn't need to copy all of the PNG files or even the netire RecordIO file over to the instance that its training on before it starts to train.

- Instead it will stream the data from its current location.

SageMaker is where most ML algos live within AWS.

- SageMaker algos generally always work best with RecordIO formats.

- Streams data directly out of the file object from S3

- Training instances don't need a local disk copy of the data

## Section -- Machine Learning Algorithms

### 17 -- Logistical Regression

A statistical analysis tool but a name for a particular type of ML algo.

A supervised ML algo.

- We provide the data to train from but also example inferences that it will aquaint with the data we provide.

- Example: we say -- here is all the data, look for patterns in the data and this is what we would want the answer to be if this was a fresh piece of data you were looking at in the future.

- Used for inferring a Yes or No. A Binary 1 or 0

- Two outcomes

- Is this an example of something or is it not.

Use Cases

- Credit Risk

- Does this person have suitable credit for this loan or not

- Medical Conditions

- Does this person have heart disease or do they not

- Person will perform action

![](../../../../media/image028.png)

Relationship between a higher resting heart rate and someone that doesn't like cats. It is easy for us to visualize this is 2d but ML algos are usually multi dimension.

![](../../../../media/image029.png)

Use Linear Regression to draw a line through the data.

The solid white line is estimating or approximating what it might look like if we took the typical linear regression approach to try to find a line of best fit with minimal sums of squares

There is an outlier off a resting heart rate = 110 which is skewing the linear regression line.

The vertical dotted line at about 85 is basically saying, if you've got a resting heart rate of below 85, then you probably do like cats. And if you have a resting heart rate above 85, then you probably don't like cats.

Linear Regression will try to fit a **sigmoid function** to the data. A **sigmoid function** is not a straight line. IT forms an S shape between the two levels of the logistical regression graph. It trends very close to the absolute, in this case, yes or no.

![](../../../../media/image030.png)

With **sigmoid functions** the outlier data point doesn't skew the line as it did with linear regression. It concentrates on finding the point at which the yes or no difference should shit. (in this graph its between 75-80, which is lower than the logistical regression).

In reality there would be a lot more data than this and dimensions but it would be processed it the same way.

This is a high level of logistical regression.

---

### 18 -- Linear Regression

One of the more basic types of ML algos.

Supervised ML Model. Provide the data to the model and the output value you want to infer later on.

Most useful when dealing with multiple dimensional data.

An example inference is numeric in that the output is over a particular range. Its not just a 1 or a 0, but an actual number which has been calculated based on the input data.

- Can be used for any kind of business question you have, where the output is a number where your drawing graphs and you're trying to figure out what value to place eon something.

![](../../../../media/image031.png)

We can see that there is somewhat of a linear relationship between the data.

Use the least sum of squares to draw a line through the data that best fits the data.

The line doesn't actually represent any actual real-world values. It provides us with a way to have a statically valid answer for anything we want to infer in the future.

Say London is at Latitude 50 and you can then infer that people in London drink around 26 cups of tea (in a month?, week?)

![](../../../../media/image032.png)

Linear Regression is used for getting a number value out of your ML model.

---

### 19 -- Support Vector Machines (SVMs)

Supervised ML Algorithm. AKA we provide the model with data and tell it what it is, what It looks like, and infer other things from this in the future.

We are looking to infer classified data. Classification. You already have a segmented data set, a classified data set.

At a high level, how a SVM is viewed.

![](../../../../media/image033.png)

Two data sets.

Use Cases, we usually have a

- Customer Classification

- Have high value customers that we can see from the overall customer base. Want to be able to easily predict who else in the customer set can become a high value customer.

- Use a SVM to put a classifier in place to be able to classify customers as they're on-boarded -- to say hey, this one is looking like its going to be a high value customer and mark it in a certain way.

- Genomic Identification

Example:

![](../../../../media/image034.png)

Two different classes of data.

SVM will provide a simple way to decide whether a new data point will be a red data point or a green data point. To classify whether the new data point will be red or green.

Draw a line between the two different classes to make determinations about new data points. The question is, is this the right place for the line. How do you determine where the best place is to draw the line?

- You look for **support vectors**.

![](../../../../media/image035.png)

- They are vectors were the sample points are closet to the other class.

- They basically illustrate the boundary or edge of the data.

- Using the support vectors you can map out margins.

![](../../../../media/image036.png)

- Draw a hyperplane between the two margins, equidistance between the two margins.

![](../../../../media/image037.png)

- The hyperplane is what the SVM will determine is the best separation of the two different categories. You can then categorize everything that's on one side of the line to be in the green category and everything on the other side of that line to be in the red category.

![](../../../../media/image038.png)

This is looking at SVMs with 2-dimensional data which makes it easy to visualize and to see what's going on with the ML algo. Normally multidimensional data is used, but the same principles apply.

---

### 20 -- Decision Trees

Supervised Algos. Provide the model with training data and labels and the labels can be seen as sample inferences.

Can be used for different types of inferences. Binary Yes or No, Numeric, Classification, etc.

Use Cases

- All different kinds of use cases.

- Customer analysis

- Medical Conditions

Essentially a flow diagram. Example of a very simple decision tree.

![](../../../../media/image039.png)

![](../../../../media/image040.png)

Root Node -- where you start. No other input from other notes.

Internal Node -- Accepts an input from somewhere else and makes an output to somewhere else.

Leaf Node -- Where a decision ends.

![](../../../../media/image041.png)

How a decision tree algo goes about building a decision tree as it trains.

Data set: (multi-dimensional). Type is label. Other columns are features.

![](../../../../media/image042.png)

Which becomes the root node?

- Which feature is correlated the most with the label.

- Likes Running

What node goes next?

- Filter the data to only those who answered Yes to Likes Running. Then perform analysis to see which feature best maps these remaining people to whether they like dogs or cats.

- Likes Walking

What if they do like walking?

- Filter out for those people and go on until you complete the branch, till you reach a leaf node.

For the next branch, filter out the people that said No to "Likes Running" and follow the same methodology until you complete the branch and reach a leaf node.

![](../../../../media/image043.png)

Notice how the column, Favorite Color, was never used. The decision tree algo figure that Favorite Color has no correlation to whether you like dogs or cats.

- Decision Tress can perform a type of feature selection.

---

### 21 -- Random Forests

Supervised Algos.

Can infer Binary outputs, Numeric outputs, and Classification outputs.

Related to Decision Trees.

- A random forest is a collection of decision trees.

Why use random forests instead of decisions trees?

- Decision Trees on their own can be somewhat inaccurate.

- Random Forests are a way to make decision trees more accurate.

Multi-dimension data set

![](../../../../media/image042.png)

Again, the feature that is going to that is going to be the root node is the feature that has the highest correlation to the label.

The Random Forest algo will pick a random subset of the features (how many depends on how many features there are and how many are configured in.).

Likes Walking and KM's Walked have been selected. The other features get ignored for the time being.

The process is now the same as when creating a decision tree. But now you are only looking at the correlation between "Likes Walking" and KM's Walked" to the label, "Type".

Likes Walking is found to have the highest correlation to the label, so it becomes the root of the decision tree.

What node goes next? Follow the same process, randomly pick features from the remaining features and make the determination, which one of these features has the highest correlation to the label.

So the decision tree is built along the way.

- Take a subset of the features that are available, and only use those to determine what the next node of the tree will be.

- You end up with a decision tree that has some random variance in it.

You do this multiple times. The number of times you do this depends on how long you have to train the model and what the performance of the random forest is looking like.

- Every time you do this, you have the possibility of coming out with a slightly different tree.

- When it comes to inference time, it's simply a case of the model surveying all of the trees to find out what the answer should be.

New data:

![](../../../../media/image044.png)

- This data is run through each of the decision trees that are created.

- The first decision tree finds that they are a Dog person. As does the second. The next one categorizes the person as a cat person. The last decision tree categorizes them as a dog person.

![](../../../../media/image045.png)

All the results of the decision trees are surveyed and the algo determines that this person is most likely to be a Dog person.

---

### 22 -- K-Means

Unsupervised algo

- We provide data to the algo, but not tell it any label or classification

Used for classification

- Find classes, groups, or clusters of data.

Give the algo a bunch of data and the algo will find groups within the data set.

Use cases:

- Data exploration

- Customer categorization

Can be used as a data preprocessing step.

The K represents a number. In most cases that is the number of classes that we want the algo to find.

In our example we will ask K means to find 3 different classes within our data.

K-Means starts by making 3 completely random guesses and finds 3 points in which it thinks could be at the center of the 3 different classes that we're looking for.

- Since the 3 points are chosen at random, they are most likely wrong.

K-Means will then go through an iterative cycle to try and find better locations for the 3 different center points.

It does this by going through each data point in the data set and finding which center point they are closest to.

Once each data point is mapped to the closest center point, the center points are then moved to be central to the points they are mapped to.

![](../../../../media/image046.png)becomes ![](../../../../media/image047.png)

K-means then goes through the cycle again and the data points are mapped to the centroid that they are closest to. This process is iterated until the centroids are at the center of the classes.

![](../../../../media/image048.png)

K-means knows it has reached equilibrium when none of that data points change which centroid they are mapped to. K-means has now found the 3 classes of data.

Sometimes the random points are chosen in a place where none of the points change which centroid they are mapped to after going through the cycle, but the classes are wrong.

![](../../../../media/image049.png)

How does K-means know which is the best?

- It does it by looking at the total variation.

- It adds up the distances between all of the blue points and the centroid of the blue class, the red points and the centroid of the red class, and the green points and the centroid of the green class.

- It does the same thing with the other attempt.

- ![](../../../../media/image050.png)

- When the total variation is added, it shows the total variation for the second attempt is far more than the first attempt and thus K-means knows the first attempt is the correct model as it has the lowest amount of variation.

How to determine what the best value for K is

- Graph the number of clusters by reduction in variation

- Reduction in variation on the y-axis, clusters(K) on the x-axis.

- Plot the first point on the 0-point on the y-axis and 1 on the x-axis. The first point is one cluster. With all the data points in one cluster, you are going to get max variation. There is no way to have more variation.

- Plotting the reduction in variation as the clusters are increased.

- When increased to 2 clusters, variation reduces.

- As the number of clusters increases, variation decreases.

- Then draw a line through all the points on the graph and you end up with an elbow plot. The elbow is the point where variation starts to not change very much.

- Look at where the elbow is and the number of clusters where the elbow is.

- In this case it is 3.

![](../../../../media/image051.png)

After 3 clusters, the reduction in variation would be less and less.

- Looking for a low number and the point where variation starts to not change very much.

K-Means will find clusters, groups, or classes within your data.

---

### 23 -- K-Nearest Neighbor

as
