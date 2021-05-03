library(psych)

# DATA PREPROCESSING

data <- read.csv("data.csv")

v_1 <- subset(data, Variant=="First in-order")
v_2 <- subset(data, Variant=="First out-of-order")

combined_names <- c(
  "Q1.Answer", "Q1.Time", "Q1.Correct",
  "Q2.Answer", "Q2.Time", "Q2.Correct",
  "Q3.Answer", "Q3.Time", "Q3.Correct",
  "Q4.Answer", "Q4.Time", "Q4.Correct")

# Create a table containing results for in-order questions.
io_1 <- cbind(
  v_1[1:2], v_1[3:5], v_1[ 9:11], v_1[15:17], v_1[21:23], v_1[27:29])
io_2 <- cbind(
  v_2[1:2], v_2[6:8], v_2[12:14], v_2[18:20], v_2[24:26], v_2[27:29])
names(io_1)[3:14] <- combined_names
names(io_2)[3:14] <- combined_names
io <- rbind(io_1, io_2)

# Create a table containing results for out-of-order questions.
oo_1 <- cbind(
  v_1[1:2], v_1[6:8], v_1[12:14], v_1[18:20], v_1[24:26], v_1[27:29])
oo_2 <- cbind(
  v_2[1:2], v_2[3:5], v_2[ 9:11], v_2[15:17], v_2[21:23], v_2[27:29])
names(oo_1)[3:14] <- combined_names
names(oo_2)[3:14] <- combined_names
oo <- rbind(oo_1, oo_2)

# DESCRIPTIVE STATISTICS

io_accuracy <- rowMeans(cbind(io[5], io[8], io[11], io[14]))
describe(io_accuracy)
oo_accuracy <- rowMeans(cbind(oo[5], oo[8], oo[11], oo[14]))
describe(oo_accuracy)

io_time <- rowMeans(cbind(io[4], io[7], io[10], io[13]))
describe(io_time)
oo_time <- rowMeans(cbind(oo[4], oo[7], oo[10], oo[13]))
describe(oo_time)

describeBy(io_accuracy, io$Computer.science.experience)
describeBy(io_accuracy, io$Jupyter.notebook.experience)

# INFERENTIAL STATISTICS

# Is there a difference between in-order and out-of-order accuracy?
t.test(
  oo_accuracy,
  io_accuracy,
  alternative="less",
  paired=TRUE,
  conf.level=0.95)

# Does the use of a colormap improve in-order accuracy?
t.test(
  subset(io_accuracy, io$Interface=="Default"),
  subset(io_accuracy, io$Interface=="Colormap"),
  alternative="less",
  paired=FALSE,
  conf.level=0.95)

# Does the use of a colormap improve in-order time?
t.test(
  subset(io_time, io$Interface=="Colormap"),
  subset(io_time, io$Interface=="Default"),
  alternative="less",
  paired=FALSE,
  conf.level=0.95)

# PLOTS

# Compare accuracy distributions between in-order and out-of-order.
boxplot(
  io_accuracy,
  oo_accuracy,
  names=c("In-order", "Out-of-order"),
  ylab="Accuracy")

# Compare in-order accuracy distributions over Jupyter experience.
boxplot(
  subset(io_accuracy, io$Jupyter.notebook.experience=="<1 year"),
  subset(io_accuracy, io$Jupyter.notebook.experience=="1-3 years"),
  subset(io_accuracy, io$Jupyter.notebook.experience==">3 years"),
  names=c("<1 year", "1-3 years", ">3 years"),
  xlab="Jupyter experience",
  ylab="Accuracy")
