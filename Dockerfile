#Arunachalm Annamalaiyar Thunai
#From my Opencv 3.2.0 image 
FROM arunswami/opencv:3.2.0
#Install other dependencies
RUN apt install -y qt4-default libeigen3-dev libboost1.58-all-dev libglew-dev freeglut3-dev

#install QGLViewer from source as apt install build on qt5, thereby causing issues 
RUN wget http://www.libqglviewer.com/src/libQGLViewer-2.6.3.tar.gz
RUN tar xvzf libQGLViewer-2.6.3.tar.gz
RUN rm libQGLViewer-2.6.3.tar.gz
WORKDIR libQGLViewer-2.6.3
RUN qmake 
RUN make 
RUN make install
#make it easier for /usr/bin/ld to find the library 
RUN ln -s /usr/local/lib/libQGLViewer.so.2.6.3 /usr/lib/libqglviewer.so
RUN ln -s /usr/local/lib/libQGLViewer.so.2.6.3 /usr/lib/libQGLViewer-qt4.so
RUN ln -s /usr/local/lib/libQGLViewer.so.2.6.3 /usr/lib/libqglviewer-qt4.so

#Copy and build the library // can also or should use git clone :P  
COPY . /home/fastfusion
WORKDIR /home/fastfusion/build
RUN cmake ..
RUN make -j8

CMD ["bin/bash", "-c"]
 
