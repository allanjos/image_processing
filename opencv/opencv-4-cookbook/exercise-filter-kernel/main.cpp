#include <cstdio>
#include <iostream>

#include <windows.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>

#define MAX_DIR_PATH 2048

using namespace std;

wstring getCurrentDirectory() {
    TCHAR buffer[MAX_DIR_PATH] = { 0 };

    GetCurrentDirectory(MAX_DIR_PATH, buffer);

    return std::wstring(buffer);
}

wstring getExecutablePath() {
    TCHAR buffer[MAX_DIR_PATH] = { 0 };

    GetModuleFileName(NULL, buffer, MAX_PATH);

    std::wstring::size_type pos = std::wstring(buffer).find_last_of(L"\\/");

    return std::wstring(buffer).substr(0, pos);
}

void sharpen2D(cv::Mat& image, cv::Mat& result) {
    cout << "sharpen2D()" << endl;

    result.create(image.size(), image.type());

    //result.row(0).setTo(cv::Scalar(0));

    cv::Mat kernel(3, 3, CV_32F, cv::Scalar(0));

    kernel.at<float>(1, 1) =  5.0;
    kernel.at<float>(0, 1) = -1.0;
    kernel.at<float>(2, 1) = -1.0;
    kernel.at<float>(1, 0) = -1.0;
    kernel.at<float>(1, 2) = -1.0;

    cv::filter2D(image, result, image.depth(), kernel);
}

int main() {
    cout << "OpenCV sharpen image" << endl;

    wcout << "Current directory: " << getCurrentDirectory() << endl;

    wcout << "Executable path: " << getExecutablePath() << endl;

    cv::Mat image = cv::imread("../resources/castle.bmp");

    cv::Mat sharpenedImage;

    sharpen2D(image, sharpenedImage);

    cv::namedWindow("Original image");
    cv::imshow("Original image", image);

    cv::namedWindow("Sharpened image");
    cv::imshow("Sharpened image", sharpenedImage);

    cv::waitKey(0);

    return 0;
}