#include <cstdio>
#include <iostream>

#include <windows.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace std;
using namespace cv;

wstring getCurrentDirectory() {
	TCHAR buffer[MAX_PATH] = { 0 };

	GetCurrentDirectory(sizeof(buffer), buffer);

	return std::wstring(buffer);
}

wstring getExecutablePath() {
	TCHAR buffer[MAX_PATH] = { 0 };

	GetModuleFileName(NULL, buffer, MAX_PATH);

	std::wstring::size_type pos = std::wstring(buffer).find_last_of(L"\\/");

	return std::wstring(buffer).substr(0, pos);
}

void onMouse(int event, int x, int y, int flags, void *param) {
	cout << "onMouse() " << endl;

	cv::Mat *image = reinterpret_cast<cv::Mat *>(param);

	switch (event) {
	case cv::EVENT_LBUTTONDOWN:
		cout << "Left mouse button click at (" << x << "," << y << ") img point value: " << static_cast<int>(image->at<uchar>(Point(x, y))) << endl;
		break;
	}
}

cv::Mat getGrayImage() {
	cv::Mat img(500, 500, CV_8U, 50);

	return img;
}

int main() {
	cout << "OpenCV ROI, image copy, mouse event" << endl;

	wcout << "Current directory: " << getCurrentDirectory() << endl;

	wcout << "Executable path: " << getExecutablePath() << endl;

	cv::namedWindow("Image 1");
	cv::namedWindow("Image 2");
	cv::namedWindow("Image 3");
	cv::namedWindow("Image 4");
	cv::namedWindow("Image 5");
	cv::namedWindow("Image");
	cv::namedWindow("Image Logo");

	cv::Mat image1(240, 320, CV_8U, 100);

	cv::imshow("Image", image1);
	cv::waitKey(0);

	image1.create(200, 200, CV_8U);
	//image1= 200;

	cv::waitKey(0);

	cv::imshow("Image", image1);
	cv::waitKey(0);

	cv::Mat image2(240, 320, CV_8UC3, cv::Scalar(0, 0, 255));

	cv::imshow("Image", image2);
	cv::waitKey(0);

	cv::Mat image3 = cv::imread("../resources/puppy.jpg");

	cv::Mat image4(image3);

	image1 = image3;

	image3.copyTo(image2);

	cv::Mat image5 = image3.clone();

	cv::flip(image3, image3, 1);

	cv::imshow("Image 3", image3);
	cv::imshow("Image 1", image1);
	cv::imshow("Image 2", image2);
	cv::imshow("Image 4", image4);
	cv::imshow("Image 5", image5);

	cv::waitKey(0);

	cv::Mat imageGray = getGrayImage();

	cv::imshow("Image", imageGray);
	cv::waitKey(0);

	image1 = cv::imread("../resources/puppy.jpg", IMREAD_GRAYSCALE);
	image1.convertTo(image2, CV_32F, 1 / 255.0, 0.0);

	cv::imshow("Image", image2);
	cv::waitKey(0);

	cv::Mat imageLogo = cv::imread("../resources/logo.png", IMREAD_GRAYSCALE);
	imageLogo.convertTo(image2, CV_32F, 1 / 255.0, 0.0);

	cv::imshow("Image Logo", imageLogo);

	cv::Rect rectRoi = cv::Rect(image1.cols - imageLogo.cols,
								image1.rows - imageLogo.rows,
						        imageLogo.cols,
								imageLogo.rows);

	cv::Mat imageRoi(image1, rectRoi);

	cv::Mat mask(imageLogo);

	imageLogo.copyTo(imageRoi, mask);

	cv::imshow("Image", image1);

	cv::waitKey(0);

	return 0;
}