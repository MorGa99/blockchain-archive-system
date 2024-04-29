import Perpic from "../Perpic";

const About = () => {
  return (
    <div class="2xl:container 2xl:mx-auto lg:py-200 lg:px-20 md:py-12 md:px-6 py-9 px-4">
      <div class="flex flex-col lg:flex-row justify-between gap-8">
        <div class="w-full lg:w-10/12 flex flex-col justify-center">
          <h1 class="text-3xl lg:text-4xl font-bold leading-9 text-gray-800 dark:text-white pb-4">
            About Us
          </h1>
          <p class="font-normal text-base leading-6 text-gray-600 dark:text-white">
            The archive system platform offers you all transportation services
            in one place, .
          </p>
        </div>
        <div class="w-full lg:w-8/12">
          <img class="w-49 " src="images\about_4.jpg" alt="A group of People" />
        </div>
      </div>

      <div class="flex lg:flex-row flex-col justify-between gap-8 pt-12">
        <div class="w-full lg:w-5/12 flex flex-col justify-center">
          <h1 class="text-3xl lg:text-4xl font-bold leading-9 text-gray-800 dark:text-white pb-4">
            Our Story
          </h1>
          <p class="font-normal text-base leading-6 text-gray-600 dark:text-white">
            We are not just software developers, Our integrated team in multiple
            fields will reveal to you the opportunities and possibilities. We
            design our website in an engineering manner so that it is
            maintainable, and we provide all the appropriate software solutions
            and systems for your company, including mobile applications and
            websites, using the latest international technologies.
          </p>
        </div>
        <div class="w-full lg:w-8/12 lg:pt-8">
          <div class="grid md:grid-cols-4 sm:grid-cols-2 grid-cols-1 lg:gap-4 shadow-lg rounded-md"></div>
        </div>
      </div>
    </div>
  );
};
export default About;
