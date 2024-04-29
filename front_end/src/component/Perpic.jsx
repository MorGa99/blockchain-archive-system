const Perpic = ({ imgLink, personName }) => {
  return (
    <div class="p-4 pb-6 flex justify-center flex-col items-center">
      <img class="md:block hidden" src={imgLink} alt="Elijah featured image" />
      <img class="md:hidden block" src={imgLink} alt="Elijah featured image" />
      <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">
        {personName}
      </p>
    </div>
  );
};

export default Perpic;
