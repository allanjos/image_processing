#include <cstdio>
#include <iostream>

#include <windows.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

#define MAX_DIR_PATH 2048

using namespace std;
using namespace cv;

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

void sharpen(cv::Mat& image, cv::Mat& result) {
    cout << "sharpen()" << endl;

    result.create(image.size(), image.type());

    //result.row(0).setTo(cv::Scalar(0));

    int channelsCount = image.channels();

    for (int j = 1; j < image.rows - 1; j++) {
        const uchar* rowPrevious = image.ptr<const uchar>(j - 1);
        const uchar* rowCurrent = image.ptr<const uchar>(j);
        const uchar* rowNext = image.ptr<const uchar>(j + 1);

        uchar* output = result.ptr<uchar>(j);

        for (int i = channelsCount; i < (image.cols - 1) * channelsCount; i++) {
            *output++ = cv::saturate_cast<uchar>(5 * rowCurrent[i]
                                                 - rowCurrent[i - channelsCount]
                                                 - rowCurrent[i + channelsCount]
                                                 - rowPrevious[i]
                                                 - rowNext[i]);
        }
    }
}

int main() {
    cout << "OpenCV sharpen image" << endl;

    wcout << "Current directory: " << getCurrentDirectory() << endl;

    wcout << "Executable path: " << getExecutablePath() << endl;

    cv::Mat image = imread("../resources/castle.bmp");

    cv::Mat sharpenedImage;

    sharpen(image, sharpenedImage);

    cv::namedWindow("Original image");
    cv::imshow("Original image", image);

    cv::namedWindow("Sharpened image");
    cv::imshow("Sharpened image", sharpenedImage);

    cv::waitKey(0);

    return 0;
}