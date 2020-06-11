## Example 4

# Prepare the data
import pandas
amtrack_df = pandas.read_csv("C:\\...\\Amtrak.csv")
amtrack_df.Month = pandas.to_datetime(amtrack_df.Month,format='%d/%m/%Y')
amtrack_df.set_index('Month', inplace=True)
ts = amtrack_df["Ridership"]

# Run the AutoRegressive model
from statsmodels.tsa.ar_model import AR
ar1 = AR(ts)
model1 = ar1.fit()

# View the results
print('Lag: %s' % model1.k_ar)
print('Coefficients: %s' % model1.params)

# Separate the data into training and test
split_size = round(len(ts)*0.3)
ts_train, ts_test = ts[0:len(ts)-split_size], ts[len(ts)-split_size:]

# Run the model again on the training data
ar2 = AR(ts_train)
model2 = ar2.fit()

print('Lag: %s' % model2.k_ar)
print('Coefficients: %s' % model2.params)

# Predicting the outcome based on the test data
ts_test_pred_ar = model2.predict(start=len(ts_train), end=len(ts_train)+len(ts_test)-1, dynamic=False)

# Comparing the real value and predicted value
for i in range(len(ts_test_pred_ar)):
	print('%i predicted=%f, true=%f' % (i, ts_test_pred_ar[i], ts_test[i]))

# Calculating the mean squared error of the model    
from sklearn.metrics import mean_squared_error
error = mean_squared_error(ts_test, ts_test_pred_ar)
print('Test MSE: %.3f' % error)

# Plot the graph comparing the real value and predicted value
from matplotlib import pyplot
pyplot.plot(ts_test)
pyplot.plot(ts_test_pred_ar)