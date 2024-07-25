import moment from 'moment'

const displayInitials = () => {
  const profilePictures = document.querySelectorAll('.profile__picture');

  if (profilePictures.length === 0) {
    return;
  }

  profilePictures.forEach(profilePicture => {
    const userName = profilePicture.dataset.userName;
    const firstChar = userName.charAt(0).toUpperCase();
    profilePicture.textContent = firstChar;
  });
}

const getTimeSinceReviewPosted = () => {
  const timestamps = document.querySelectorAll('.time-posted');

  timestamps.forEach(timestamp => {
    const timeNow = timestamp.dataset.dateNow;
    const createAt = timestamp.dataset.createdAt;

    timestamp.textContent = moment(createAt).from(timeNow);
  })
}

window.addEventListener('DOMContentLoaded', () => {
  displayInitials();
  getTimeSinceReviewPosted();
});
