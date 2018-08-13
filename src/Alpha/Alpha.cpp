#include <stdio.h>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

Mat changeAlpha(Mat mask, Mat fore, Mat back, float alpha) {

  Mat result = Mat::zeros(fore.size(), fore.type());

  fore.convertTo(fore, CV_32FC3);
  back.convertTo(back, CV_32FC3);

  // Normalizando a mascara
  mask.convertTo(mask, CV_32FC3, alpha/255); 
 
  // Multiplicando a mascara pelo foreground e atribuindo ao foreground
  multiply(mask, fore, fore); 
 
  // Multiplicando o background por ( 1 - mascara ) e atribuindo ao background
  multiply(Scalar::all(1.0)-mask, back, back); 
 
  // Adicionando background e foreground após terem sido aplicadas as mascaras...
  add(fore, back, result); 

  return result/255;
}

int main() {
  
  Mat mask = imread("imgs/alpha_channel.png");
  Mat fore = imread("imgs/foreground.png");
  Mat back = imread("imgs/background.jpg");

  float alpha;
  cout<<"Digite o alpha"<<endl;
  cin>>alpha;

  Mat r = changeAlpha(mask,fore,back,alpha);
     
  cv::imwrite("Result.png",r*255);
  cv::imshow("Result",r);
  cv::waitKey(0);

  return 0;

}