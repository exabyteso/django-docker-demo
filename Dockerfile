#You must specify what image or context will be used for running the language,
#or platform specific commands for creating the Docker Image using the FROM
#command.

#If you're using multiple language, or platforms, you will need to do
#a multistage build which is beyond the scope of this section on
#Dockerizing your Django application.

#The command below instructs docker to use Python 3.7.2 to run the commands
#specified in the CMD or RUN sections

#The Python 3.7.2 image is very heavy i.e. it used a lot of memory (about half a GB)
#This is where you may apply the first Docker Image efficiency hacks
#Official Docker images normally have 3 "compressed" versions of images including:
#stretch, slim-stretch, and alpine (ordered from highest to lowest in size)
#The catch with the Alpine image is that you may need to modify the syntax
#of your commands
#Check the Docker Python Images for these at https://hub.docker.com/_/python/
FROM python:3.7.2-slim-stretch

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

#Make a directory within your container for your application's files
RUN mkdir -p /myapp

#Specify the directory where all CMD and RUN commands will be executed
WORKDIR /myapp

ADD requirements.txt /myapp/

RUN pip install -r requirements.txt

#Copy all the files in the current directory into /myapp
ADD . /myapp
