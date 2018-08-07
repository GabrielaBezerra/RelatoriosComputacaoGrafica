#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/core.hpp>

using namespace cv;

std::string type2str(int type) {
  std::string r;

  uchar depth = type & CV_MAT_DEPTH_MASK;
  uchar chans = 1 + (type >> CV_CN_SHIFT);

  switch ( depth ) {
    case CV_8U:  r = "8U"; break;
    case CV_8S:  r = "8S"; break;
    case CV_16U: r = "16U"; break;
    case CV_16S: r = "16S"; break;
    case CV_32S: r = "32S"; break;
    case CV_32F: r = "32F"; break;
    case CV_64F: r = "64F"; break;
    default:     r = "User"; break;
  }

  r += "C";
  r += (chans+'0');

  return r;
}

void filtroDaMedia(Mat image, int masksize) {
    Mat mask = Mat::ones(masksize, masksize, CV_32FC1 )/(float)(masksize*masksize);
    int sizediff = mask.rows/2;
    int newsize = image.rows+(sizediff*2);
    
    Mat tmpImg = Mat::zeros(newsize, newsize, CV_8UC1);    
    
    printf("Matrix: %s %dx%d\n", type2str(image.type()).c_str(),  image.rows,  image.cols );
    printf("Mask  : %s %dx%d\n"  , type2str(mask.type()).c_str(), mask.rows,   mask.cols  );
    printf("TmpImg: %s %dx%d\n", type2str(tmpImg.type()).c_str(), tmpImg.rows, tmpImg.cols);
    printf("sizediff: %d\n",sizediff);

    image.copyTo(tmpImg(cv::Rect(sizediff,sizediff,image.cols, image.rows)));

    // cv::namedWindow("BorderWithZeros", WINDOW_AUTOSIZE );
    // cv::imshow("BorderWithZeros", tmpImg);
    
    cv::imwrite("src/Trabalho01/FiltroDaMedia/Mascara7/ImagemComBordasZeroMascara7.pgm",tmpImg);

    //FiltroDaMedia
    Mat filteredImg;
    filter2D(tmpImg,filteredImg,-1,mask);

    cv::imwrite("src/Trabalho01/FiltroDaMedia/Mascara7/ResultadoFiltroDaMediaMascara7.pgm",filteredImg);

    cv::imshow("FiltroDaMedia",filteredImg);   
}

void filtroMediana(Mat image, int masksize) {
    Mat mask = Mat::ones(masksize, masksize, CV_32FC1 )/(float)(masksize*masksize);
    int sizediff = mask.rows/2;
    int newsize = image.rows+(sizediff*2);
    
    Mat tmpImg = Mat::zeros(newsize, newsize, CV_8UC1);    
    
    printf("Matrix: %s %dx%d\n", type2str(image.type()).c_str(),  image.rows,  image.cols );
    printf("Mask  : %s %dx%d\n"  , type2str(mask.type()).c_str(), mask.rows,   mask.cols  );
    printf("TmpImg: %s %dx%d\n", type2str(tmpImg.type()).c_str(), tmpImg.rows, tmpImg.cols);
    printf("sizediff: %d\n",sizediff);

    image.copyTo(tmpImg(cv::Rect(sizediff,sizediff,image.cols, image.rows)));

    // cv::namedWindow("BorderWithZeros", WINDOW_AUTOSIZE );
    // cv::imshow("BorderWithZeros", tmpImg);
    
    cv::imwrite("src/Trabalho01/FiltroDaMedia/Mascara7/ImagemComBordasZeroMascara7.pgm",tmpImg);

    //FiltroDaMediana
    Mat filteredImg;
    medianBlur(tmpImg,filteredImg,masksize);

    cv::imwrite("src/Trabalho01/FiltroDaMedia/Mascara7/ResultadoFiltroDaMediaMascara7.pgm",filteredImg);

    cv::imshow("FiltroDaMedia",filteredImg);  
}

void ajusteDeContraste(Mat image, float contrast, float brightness) {
    
    image.convertTo(image, -1, contrast, brightness);
    
    cv::imwrite("src/Trabalho01/Contraste/Contraste2.5.pgm",image);
    cv::imshow("Ajuste de Contraste",image);
}

void limiarizacao(Mat image, float limiar) {
    for (int i = 0; i < image.cols; i++) {
        for (int j = 0; j < image.rows; j++) {
            float value = (float)image.ptr<uchar>(i)[j];
            if (value >= limiar) {                
                image.ptr<uchar>(i)[j] = 255;
            } else {
                image.ptr<uchar>(i)[j] = 0;
            }
        }
    }

    cv::imwrite("src/Trabalho01/Limiarizacao/Limiar180.pgm",image);
    cv::imshow("Limiarizacao",image);
}



int main(int argc, char** argv )
{
    //Checking parameters
    if ( argc != 3 )
    {
        printf("usage: DisplayImage.out <Image_Path> <Mask_Size>\n");
        return -1;
    }

    Mat image;
    image = imread(argv[1], CV_8UC1);

    if ( !image.data )
    {
        printf("No image data \n");
        return -1;
    }    

    // filtroDaMedia( image, atoi(argv[2]) );
    // filtroMediana( image, atoi(argv[2]) );
    // ajusteDeContraste( image, 2.5, 0);
    // limiarizacao( image, 180 );
    

    cv::waitKey(0);
    return 0;    
}